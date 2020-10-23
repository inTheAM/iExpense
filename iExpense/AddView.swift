//
//  AddView.swift
//  iExpense
//
//  Created by Ahmed Mgua on 8/1/20.
//

import SwiftUI

struct AddView: View {
	
	@State	private	var	expenseName	=	""
	@State	private	var	amount	=	""
	@State	private	var	type:	Types	=	.personal
	@Environment(\.presentationMode)	var	presentationMode

	enum Types:	String,	CaseIterable,	Identifiable	{
		var id:	Types	{	self	}
		case	business	=	"Business",	personal	=	"Personal"
	}
	
	@ObservedObject	var	expenses:	Expenses
	
	var body: some View {
		NavigationView	{
			Form	{
				Section	{
					TextField("Name",	text:	$expenseName)
					
					Picker("Type",	selection:	$type)	{
						ForEach(Types.allCases)	{ type in
							Text(type.rawValue)
						}
					}
					
					TextField("Amount",	text:	$amount)
						.keyboardType(.numberPad)
				}
				HStack(alignment:	.center)	{
					Spacer()
					Button("Save")	{
						
						if	let	actualAmount	=	Int(amount)	{
							let item	=	ExpenseItem(id: UUID(), name: expenseName, type: type.rawValue, amount: actualAmount)
							expenses.items.append(item)
							self.presentationMode.wrappedValue.dismiss()
							
						}
					}
					Spacer()
				}
			}
			.navigationBarTitle("Add new expense")
		}
	}
}

struct AddView_Previews: PreviewProvider {
	static var previews: some View {
		AddView(expenses: Expenses())
	}
}
