//  AdvicesPresenter.swift
//
//  Created by Elora on 04/05/2023.
//

/// `AdvicesPresenter` acts as the middleman between the `AdvicesInteractor` and `AdvicesViewModel`.
/// It processes data received from the interactor and updates the ViewModel.
class AdvicesPresenter: Presenter<AdvicesViewModel> {
	
	/// Updates the ViewModel with advice data and triggers a UI refresh in the associated view controller.
	/// - Parameter sections: The `AdvicesResponse` containing the sections of advices.
	/// This method processes the advice data, including injecting CSS styles into HTML content, before updating the ViewModel.
	func display(sections: AdvicesResponse) {
		
		// CSS styles to be applied to the advice content.
		let cssStyle = """
   <style>
   h1 {
   font-family: Arial, sans-serif;
   font-size: 68px;
   color: #333;
   }
   h2 {
   font-family: 'Helvetica Neue', sans-serif;
   font-size: 52px;
   color: #0077b6;
   }
   p {
   font-family: 'Helvetica Neue', sans-serif;
   font-size: 48px;
   color: #666;
   }
   </style>
   """
		// Mapping and updating each section with the CSS styles.
		let updatedSections = sections.sections.map { section in
			let updatedAdvices = section.advices.map { advice in
				var updatedAdvice = advice
				
				// Inserting CSS styles into the HTML content of each advice.
				if let range = updatedAdvice.advice.range(of: "<head>") {
					
					updatedAdvice.advice.insert(contentsOf: cssStyle, at: range.upperBound)
				}
				
				return updatedAdvice
			}
			
			return AdvicesResponse.Section(sectionTitle: section.sectionTitle, advices: updatedAdvices)
		}
		
		let updatedAdvicesResponse = AdvicesResponse(sections: updatedSections)
		
		
		// Updating the ViewModel with the processed advice data.
		self.viewModel?.sections = updatedAdvicesResponse
		// Notifying the ViewModel to update the UI.
		self.viewModel?.send()
	}
}
