//  AdvicesPresenter.swift
//
//  Created by Elora on 04/05/2023.
//

class AdvicesPresenter: Presenter<AdvicesViewModel> {
	
	func display(sections: AdvicesResponse) {
		
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
		//		Balise CSS à mettre dans chaque Header
		
		let updatedSections = sections.sections.map { section in
			var updatedAdvices = section.advices.map { advice in
				var updatedAdvice = advice
				
				if let range = updatedAdvice.advice.range(of: "<head>") {
					
					// Insérer les styles après "<head>"
					updatedAdvice.advice.insert(contentsOf: cssStyle, at: range.upperBound)
				}
				
				return updatedAdvice
			}
			
			return AdvicesResponse.Section(sectionTitle: section.sectionTitle, advices: updatedAdvices)
		}
		
		let updatedAdvicesResponse = AdvicesResponse(sections: updatedSections)
		
		
		
		self.viewModel?.sections = updatedAdvicesResponse
		self.viewModel?.send()
	}
}
