/*******************************************************************************
 * Copyright (c) 2015 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
grammar PsiInternalEntities;

options {
	superClass=AbstractPsiAntlrParser;
}

@lexer::header {
package org.eclipse.xtext.idea.example.entities.idea.parser.antlr.internal;

// Hack: Use our own Lexer superclass by means of import. 
// Currently there is no other way to specify the superclass for the lexer.
import org.eclipse.xtext.parser.antlr.Lexer;
}

@parser::header {
package org.eclipse.xtext.idea.example.entities.idea.parser.antlr.internal;

import org.eclipse.xtext.idea.parser.AbstractPsiAntlrParser;
import org.eclipse.xtext.idea.example.entities.idea.lang.EntitiesElementTypeProvider;
import org.eclipse.xtext.idea.parser.TokenTypeProvider;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.idea.example.entities.services.EntitiesGrammarAccess;

import com.intellij.lang.PsiBuilder;
}

@parser::members {

	protected EntitiesGrammarAccess grammarAccess;

	protected EntitiesElementTypeProvider elementTypeProvider;

	public PsiInternalEntitiesParser(PsiBuilder builder, TokenStream input, EntitiesElementTypeProvider elementTypeProvider, EntitiesGrammarAccess grammarAccess) {
		this(input);
		setPsiBuilder(builder);
		this.grammarAccess = grammarAccess;
		this.elementTypeProvider = elementTypeProvider;
	}

	@Override
	protected String getFirstRuleName() {
		return "Entities";
	}

}

//Entry rule entryRuleEntities
entryRuleEntities returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getEntitiesElementType()); }
	iv_ruleEntities=ruleEntities
	{ $current=$iv_ruleEntities.current; }
	EOF;

// Rule Entities
ruleEntities returns [Boolean current=false]
:
	(
		(
			(
				{
					markComposite(elementTypeProvider.getEntities_ImportSectionXImportSectionParserRuleCall_0_0ElementType());
				}
				lv_importSection_0_0=ruleXImportSection
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)?
		(
			(
				{
					markComposite(elementTypeProvider.getEntities_ElementsAbstractElementParserRuleCall_1_0ElementType());
				}
				lv_elements_1_0=ruleAbstractElement
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)*
	)
;

//Entry rule entryRuleAbstractElement
entryRuleAbstractElement returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getAbstractElementElementType()); }
	iv_ruleAbstractElement=ruleAbstractElement
	{ $current=$iv_ruleAbstractElement.current; }
	EOF;

// Rule AbstractElement
ruleAbstractElement returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getAbstractElement_PackageDeclarationParserRuleCall_0ElementType());
		}
		this_PackageDeclaration_0=rulePackageDeclaration
		{
			$current = $this_PackageDeclaration_0.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getAbstractElement_EntityParserRuleCall_1ElementType());
		}
		this_Entity_1=ruleEntity
		{
			$current = $this_Entity_1.current;
			doneComposite();
		}
	)
;

//Entry rule entryRulePackageDeclaration
entryRulePackageDeclaration returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getPackageDeclarationElementType()); }
	iv_rulePackageDeclaration=rulePackageDeclaration
	{ $current=$iv_rulePackageDeclaration.current; }
	EOF;

// Rule PackageDeclaration
rulePackageDeclaration returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getPackageDeclaration_PackageKeyword_0ElementType());
		}
		otherlv_0='package'
		{
			doneLeaf(otherlv_0);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getPackageDeclaration_NameQualifiedNameParserRuleCall_1_0ElementType());
				}
				lv_name_1_0=ruleQualifiedName
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		{
			markLeaf(elementTypeProvider.getPackageDeclaration_LeftCurlyBracketKeyword_2ElementType());
		}
		otherlv_2='{'
		{
			doneLeaf(otherlv_2);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getPackageDeclaration_ElementsAbstractElementParserRuleCall_3_0ElementType());
				}
				lv_elements_3_0=ruleAbstractElement
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)*
		{
			markLeaf(elementTypeProvider.getPackageDeclaration_RightCurlyBracketKeyword_4ElementType());
		}
		otherlv_4='}'
		{
			doneLeaf(otherlv_4);
		}
	)
;

//Entry rule entryRuleEntity
entryRuleEntity returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getEntityElementType()); }
	iv_ruleEntity=ruleEntity
	{ $current=$iv_ruleEntity.current; }
	EOF;

// Rule Entity
ruleEntity returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getEntity_EntityKeyword_0ElementType());
		}
		otherlv_0='entity'
		{
			doneLeaf(otherlv_0);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getEntity_NameValidIDParserRuleCall_1_0ElementType());
				}
				lv_name_1_0=ruleValidID
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		(
			{
				markLeaf(elementTypeProvider.getEntity_ExtendsKeyword_2_0ElementType());
			}
			otherlv_2='extends'
			{
				doneLeaf(otherlv_2);
			}
			(
				(
					{
						markComposite(elementTypeProvider.getEntity_SuperTypeJvmParameterizedTypeReferenceParserRuleCall_2_1_0ElementType());
					}
					lv_superType_3_0=ruleJvmParameterizedTypeReference
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)?
		{
			markLeaf(elementTypeProvider.getEntity_LeftCurlyBracketKeyword_3ElementType());
		}
		otherlv_4='{'
		{
			doneLeaf(otherlv_4);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getEntity_FeaturesFeatureParserRuleCall_4_0ElementType());
				}
				lv_features_5_0=ruleFeature
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)*
		{
			markLeaf(elementTypeProvider.getEntity_RightCurlyBracketKeyword_5ElementType());
		}
		otherlv_6='}'
		{
			doneLeaf(otherlv_6);
		}
	)
;

//Entry rule entryRuleFeature
entryRuleFeature returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getFeatureElementType()); }
	iv_ruleFeature=ruleFeature
	{ $current=$iv_ruleFeature.current; }
	EOF;

// Rule Feature
ruleFeature returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getFeature_PropertyParserRuleCall_0ElementType());
		}
		this_Property_0=ruleProperty
		{
			$current = $this_Property_0.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getFeature_OperationParserRuleCall_1ElementType());
		}
		this_Operation_1=ruleOperation
		{
			$current = $this_Operation_1.current;
			doneComposite();
		}
	)
;

//Entry rule entryRuleProperty
entryRuleProperty returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getPropertyElementType()); }
	iv_ruleProperty=ruleProperty
	{ $current=$iv_ruleProperty.current; }
	EOF;

// Rule Property
ruleProperty returns [Boolean current=false]
:
	(
		(
			(
				{
					markComposite(elementTypeProvider.getProperty_NameValidIDParserRuleCall_0_0ElementType());
				}
				lv_name_0_0=ruleValidID
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		{
			markLeaf(elementTypeProvider.getProperty_ColonKeyword_1ElementType());
		}
		otherlv_1=':'
		{
			doneLeaf(otherlv_1);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getProperty_TypeJvmTypeReferenceParserRuleCall_2_0ElementType());
				}
				lv_type_2_0=ruleJvmTypeReference
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleOperation
entryRuleOperation returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getOperationElementType()); }
	iv_ruleOperation=ruleOperation
	{ $current=$iv_ruleOperation.current; }
	EOF;

// Rule Operation
ruleOperation returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getOperation_OpKeyword_0ElementType());
		}
		otherlv_0='op'
		{
			doneLeaf(otherlv_0);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getOperation_NameValidIDParserRuleCall_1_0ElementType());
				}
				lv_name_1_0=ruleValidID
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		{
			markLeaf(elementTypeProvider.getOperation_LeftParenthesisKeyword_2ElementType());
		}
		otherlv_2='('
		{
			doneLeaf(otherlv_2);
		}
		(
			(
				(
					{
						markComposite(elementTypeProvider.getOperation_ParamsFullJvmFormalParameterParserRuleCall_3_0_0ElementType());
					}
					lv_params_3_0=ruleFullJvmFormalParameter
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			(
				{
					markLeaf(elementTypeProvider.getOperation_CommaKeyword_3_1_0ElementType());
				}
				otherlv_4=','
				{
					doneLeaf(otherlv_4);
				}
				(
					(
						{
							markComposite(elementTypeProvider.getOperation_ParamsFullJvmFormalParameterParserRuleCall_3_1_1_0ElementType());
						}
						lv_params_5_0=ruleFullJvmFormalParameter
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)*
		)?
		{
			markLeaf(elementTypeProvider.getOperation_RightParenthesisKeyword_4ElementType());
		}
		otherlv_6=')'
		{
			doneLeaf(otherlv_6);
		}
		(
			{
				markLeaf(elementTypeProvider.getOperation_ColonKeyword_5_0ElementType());
			}
			otherlv_7=':'
			{
				doneLeaf(otherlv_7);
			}
			(
				(
					{
						markComposite(elementTypeProvider.getOperation_TypeJvmTypeReferenceParserRuleCall_5_1_0ElementType());
					}
					lv_type_8_0=ruleJvmTypeReference
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)?
		(
			(
				{
					markComposite(elementTypeProvider.getOperation_BodyXBlockExpressionParserRuleCall_6_0ElementType());
				}
				lv_body_9_0=ruleXBlockExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleXExpression
entryRuleXExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXExpressionElementType()); }
	iv_ruleXExpression=ruleXExpression
	{ $current=$iv_ruleXExpression.current; }
	EOF;

// Rule XExpression
ruleXExpression returns [Boolean current=false]
:
	{
		markComposite(elementTypeProvider.getXExpression_XAssignmentParserRuleCallElementType());
	}
	this_XAssignment_0=ruleXAssignment
	{
		$current = $this_XAssignment_0.current;
		doneComposite();
	}
;

//Entry rule entryRuleXAssignment
entryRuleXAssignment returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXAssignmentElementType()); }
	iv_ruleXAssignment=ruleXAssignment
	{ $current=$iv_ruleXAssignment.current; }
	EOF;

// Rule XAssignment
ruleXAssignment returns [Boolean current=false]
:
	(
		(
			(
				{
					precedeComposite(elementTypeProvider.getXAssignment_XAssignmentAction_0_0ElementType());
					doneComposite();
					associateWithSemanticElement();
				}
			)
			(
				(
					{
						if (!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
					{
						markComposite(elementTypeProvider.getXAssignment_FeatureJvmIdentifiableElementCrossReference_0_1_0ElementType());
					}
					ruleFeatureCallID
					{
						doneComposite();
					}
				)
			)
			{
				markComposite(elementTypeProvider.getXAssignment_OpSingleAssignParserRuleCall_0_2ElementType());
			}
			ruleOpSingleAssign
			{
				doneComposite();
			}
			(
				(
					{
						markComposite(elementTypeProvider.getXAssignment_ValueXAssignmentParserRuleCall_0_3_0ElementType());
					}
					lv_value_3_0=ruleXAssignment
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)
		    |
		(
			{
				markComposite(elementTypeProvider.getXAssignment_XOrExpressionParserRuleCall_1_0ElementType());
			}
			this_XOrExpression_4=ruleXOrExpression
			{
				$current = $this_XOrExpression_4.current;
				doneComposite();
			}
			(
				(
					((
						(
						)
						(
							(
								ruleOpMultiAssign
							)
						)
					)
					)=>
					(
						(
							{
								precedeComposite(elementTypeProvider.getXAssignment_XBinaryOperationLeftOperandAction_1_1_0_0_0ElementType());
								doneComposite();
								associateWithSemanticElement();
							}
						)
						(
							(
								{
									if (!$current) {
										associateWithSemanticElement();
										$current = true;
									}
								}
								{
									markComposite(elementTypeProvider.getXAssignment_FeatureJvmIdentifiableElementCrossReference_1_1_0_0_1_0ElementType());
								}
								ruleOpMultiAssign
								{
									doneComposite();
								}
							)
						)
					)
				)
				(
					(
						{
							markComposite(elementTypeProvider.getXAssignment_RightOperandXAssignmentParserRuleCall_1_1_1_0ElementType());
						}
						lv_rightOperand_7_0=ruleXAssignment
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)?
		)
	)
;

//Entry rule entryRuleOpSingleAssign
entryRuleOpSingleAssign returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getOpSingleAssignElementType()); }
	iv_ruleOpSingleAssign=ruleOpSingleAssign
	{ $current=$iv_ruleOpSingleAssign.current; }
	EOF;

// Rule OpSingleAssign
ruleOpSingleAssign returns [Boolean current=false]
:
	{
		markLeaf(elementTypeProvider.getOpSingleAssign_EqualsSignKeywordElementType());
	}
	kw='='
	{
		doneLeaf(kw);
	}
;

//Entry rule entryRuleOpMultiAssign
entryRuleOpMultiAssign returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getOpMultiAssignElementType()); }
	iv_ruleOpMultiAssign=ruleOpMultiAssign
	{ $current=$iv_ruleOpMultiAssign.current; }
	EOF;

// Rule OpMultiAssign
ruleOpMultiAssign returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getOpMultiAssign_PlusSignEqualsSignKeyword_0ElementType());
		}
		kw='+='
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpMultiAssign_HyphenMinusEqualsSignKeyword_1ElementType());
		}
		kw='-='
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpMultiAssign_AsteriskEqualsSignKeyword_2ElementType());
		}
		kw='*='
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpMultiAssign_SolidusEqualsSignKeyword_3ElementType());
		}
		kw='/='
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpMultiAssign_PercentSignEqualsSignKeyword_4ElementType());
		}
		kw='%='
		{
			doneLeaf(kw);
		}
		    |
		(
			{
				markLeaf(elementTypeProvider.getOpMultiAssign_LessThanSignKeyword_5_0ElementType());
			}
			kw='<'
			{
				doneLeaf(kw);
			}
			{
				markLeaf(elementTypeProvider.getOpMultiAssign_LessThanSignKeyword_5_1ElementType());
			}
			kw='<'
			{
				doneLeaf(kw);
			}
			{
				markLeaf(elementTypeProvider.getOpMultiAssign_EqualsSignKeyword_5_2ElementType());
			}
			kw='='
			{
				doneLeaf(kw);
			}
		)
		    |
		(
			{
				markLeaf(elementTypeProvider.getOpMultiAssign_GreaterThanSignKeyword_6_0ElementType());
			}
			kw='>'
			{
				doneLeaf(kw);
			}
			(
				{
					markLeaf(elementTypeProvider.getOpMultiAssign_GreaterThanSignKeyword_6_1ElementType());
				}
				kw='>'
				{
					doneLeaf(kw);
				}
			)?
			{
				markLeaf(elementTypeProvider.getOpMultiAssign_GreaterThanSignEqualsSignKeyword_6_2ElementType());
			}
			kw='>='
			{
				doneLeaf(kw);
			}
		)
	)
;

//Entry rule entryRuleXOrExpression
entryRuleXOrExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXOrExpressionElementType()); }
	iv_ruleXOrExpression=ruleXOrExpression
	{ $current=$iv_ruleXOrExpression.current; }
	EOF;

// Rule XOrExpression
ruleXOrExpression returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXOrExpression_XAndExpressionParserRuleCall_0ElementType());
		}
		this_XAndExpression_0=ruleXAndExpression
		{
			$current = $this_XAndExpression_0.current;
			doneComposite();
		}
		(
			(
				((
					(
					)
					(
						(
							ruleOpOr
						)
					)
				)
				)=>
				(
					(
						{
							precedeComposite(elementTypeProvider.getXOrExpression_XBinaryOperationLeftOperandAction_1_0_0_0ElementType());
							doneComposite();
							associateWithSemanticElement();
						}
					)
					(
						(
							{
								if (!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
							{
								markComposite(elementTypeProvider.getXOrExpression_FeatureJvmIdentifiableElementCrossReference_1_0_0_1_0ElementType());
							}
							ruleOpOr
							{
								doneComposite();
							}
						)
					)
				)
			)
			(
				(
					{
						markComposite(elementTypeProvider.getXOrExpression_RightOperandXAndExpressionParserRuleCall_1_1_0ElementType());
					}
					lv_rightOperand_3_0=ruleXAndExpression
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)*
	)
;

//Entry rule entryRuleOpOr
entryRuleOpOr returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getOpOrElementType()); }
	iv_ruleOpOr=ruleOpOr
	{ $current=$iv_ruleOpOr.current; }
	EOF;

// Rule OpOr
ruleOpOr returns [Boolean current=false]
:
	{
		markLeaf(elementTypeProvider.getOpOr_VerticalLineVerticalLineKeywordElementType());
	}
	kw='||'
	{
		doneLeaf(kw);
	}
;

//Entry rule entryRuleXAndExpression
entryRuleXAndExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXAndExpressionElementType()); }
	iv_ruleXAndExpression=ruleXAndExpression
	{ $current=$iv_ruleXAndExpression.current; }
	EOF;

// Rule XAndExpression
ruleXAndExpression returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXAndExpression_XEqualityExpressionParserRuleCall_0ElementType());
		}
		this_XEqualityExpression_0=ruleXEqualityExpression
		{
			$current = $this_XEqualityExpression_0.current;
			doneComposite();
		}
		(
			(
				((
					(
					)
					(
						(
							ruleOpAnd
						)
					)
				)
				)=>
				(
					(
						{
							precedeComposite(elementTypeProvider.getXAndExpression_XBinaryOperationLeftOperandAction_1_0_0_0ElementType());
							doneComposite();
							associateWithSemanticElement();
						}
					)
					(
						(
							{
								if (!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
							{
								markComposite(elementTypeProvider.getXAndExpression_FeatureJvmIdentifiableElementCrossReference_1_0_0_1_0ElementType());
							}
							ruleOpAnd
							{
								doneComposite();
							}
						)
					)
				)
			)
			(
				(
					{
						markComposite(elementTypeProvider.getXAndExpression_RightOperandXEqualityExpressionParserRuleCall_1_1_0ElementType());
					}
					lv_rightOperand_3_0=ruleXEqualityExpression
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)*
	)
;

//Entry rule entryRuleOpAnd
entryRuleOpAnd returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getOpAndElementType()); }
	iv_ruleOpAnd=ruleOpAnd
	{ $current=$iv_ruleOpAnd.current; }
	EOF;

// Rule OpAnd
ruleOpAnd returns [Boolean current=false]
:
	{
		markLeaf(elementTypeProvider.getOpAnd_AmpersandAmpersandKeywordElementType());
	}
	kw='&&'
	{
		doneLeaf(kw);
	}
;

//Entry rule entryRuleXEqualityExpression
entryRuleXEqualityExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXEqualityExpressionElementType()); }
	iv_ruleXEqualityExpression=ruleXEqualityExpression
	{ $current=$iv_ruleXEqualityExpression.current; }
	EOF;

// Rule XEqualityExpression
ruleXEqualityExpression returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXEqualityExpression_XRelationalExpressionParserRuleCall_0ElementType());
		}
		this_XRelationalExpression_0=ruleXRelationalExpression
		{
			$current = $this_XRelationalExpression_0.current;
			doneComposite();
		}
		(
			(
				((
					(
					)
					(
						(
							ruleOpEquality
						)
					)
				)
				)=>
				(
					(
						{
							precedeComposite(elementTypeProvider.getXEqualityExpression_XBinaryOperationLeftOperandAction_1_0_0_0ElementType());
							doneComposite();
							associateWithSemanticElement();
						}
					)
					(
						(
							{
								if (!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
							{
								markComposite(elementTypeProvider.getXEqualityExpression_FeatureJvmIdentifiableElementCrossReference_1_0_0_1_0ElementType());
							}
							ruleOpEquality
							{
								doneComposite();
							}
						)
					)
				)
			)
			(
				(
					{
						markComposite(elementTypeProvider.getXEqualityExpression_RightOperandXRelationalExpressionParserRuleCall_1_1_0ElementType());
					}
					lv_rightOperand_3_0=ruleXRelationalExpression
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)*
	)
;

//Entry rule entryRuleOpEquality
entryRuleOpEquality returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getOpEqualityElementType()); }
	iv_ruleOpEquality=ruleOpEquality
	{ $current=$iv_ruleOpEquality.current; }
	EOF;

// Rule OpEquality
ruleOpEquality returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getOpEquality_EqualsSignEqualsSignKeyword_0ElementType());
		}
		kw='=='
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpEquality_ExclamationMarkEqualsSignKeyword_1ElementType());
		}
		kw='!='
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpEquality_EqualsSignEqualsSignEqualsSignKeyword_2ElementType());
		}
		kw='==='
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpEquality_ExclamationMarkEqualsSignEqualsSignKeyword_3ElementType());
		}
		kw='!=='
		{
			doneLeaf(kw);
		}
	)
;

//Entry rule entryRuleXRelationalExpression
entryRuleXRelationalExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXRelationalExpressionElementType()); }
	iv_ruleXRelationalExpression=ruleXRelationalExpression
	{ $current=$iv_ruleXRelationalExpression.current; }
	EOF;

// Rule XRelationalExpression
ruleXRelationalExpression returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXRelationalExpression_XOtherOperatorExpressionParserRuleCall_0ElementType());
		}
		this_XOtherOperatorExpression_0=ruleXOtherOperatorExpression
		{
			$current = $this_XOtherOperatorExpression_0.current;
			doneComposite();
		}
		(
			(
				(
					((
						(
						)
						'instanceof'
					)
					)=>
					(
						(
							{
								precedeComposite(elementTypeProvider.getXRelationalExpression_XInstanceOfExpressionExpressionAction_1_0_0_0_0ElementType());
								doneComposite();
								associateWithSemanticElement();
							}
						)
						{
							markLeaf(elementTypeProvider.getXRelationalExpression_InstanceofKeyword_1_0_0_0_1ElementType());
						}
						otherlv_2='instanceof'
						{
							doneLeaf(otherlv_2);
						}
					)
				)
				(
					(
						{
							markComposite(elementTypeProvider.getXRelationalExpression_TypeJvmTypeReferenceParserRuleCall_1_0_1_0ElementType());
						}
						lv_type_3_0=ruleJvmTypeReference
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)
			    |
			(
				(
					((
						(
						)
						(
							(
								ruleOpCompare
							)
						)
					)
					)=>
					(
						(
							{
								precedeComposite(elementTypeProvider.getXRelationalExpression_XBinaryOperationLeftOperandAction_1_1_0_0_0ElementType());
								doneComposite();
								associateWithSemanticElement();
							}
						)
						(
							(
								{
									if (!$current) {
										associateWithSemanticElement();
										$current = true;
									}
								}
								{
									markComposite(elementTypeProvider.getXRelationalExpression_FeatureJvmIdentifiableElementCrossReference_1_1_0_0_1_0ElementType());
								}
								ruleOpCompare
								{
									doneComposite();
								}
							)
						)
					)
				)
				(
					(
						{
							markComposite(elementTypeProvider.getXRelationalExpression_RightOperandXOtherOperatorExpressionParserRuleCall_1_1_1_0ElementType());
						}
						lv_rightOperand_6_0=ruleXOtherOperatorExpression
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)
		)*
	)
;

//Entry rule entryRuleOpCompare
entryRuleOpCompare returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getOpCompareElementType()); }
	iv_ruleOpCompare=ruleOpCompare
	{ $current=$iv_ruleOpCompare.current; }
	EOF;

// Rule OpCompare
ruleOpCompare returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getOpCompare_GreaterThanSignEqualsSignKeyword_0ElementType());
		}
		kw='>='
		{
			doneLeaf(kw);
		}
		    |
		(
			{
				markLeaf(elementTypeProvider.getOpCompare_LessThanSignKeyword_1_0ElementType());
			}
			kw='<'
			{
				doneLeaf(kw);
			}
			{
				markLeaf(elementTypeProvider.getOpCompare_EqualsSignKeyword_1_1ElementType());
			}
			kw='='
			{
				doneLeaf(kw);
			}
		)
		    |
		{
			markLeaf(elementTypeProvider.getOpCompare_GreaterThanSignKeyword_2ElementType());
		}
		kw='>'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpCompare_LessThanSignKeyword_3ElementType());
		}
		kw='<'
		{
			doneLeaf(kw);
		}
	)
;

//Entry rule entryRuleXOtherOperatorExpression
entryRuleXOtherOperatorExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXOtherOperatorExpressionElementType()); }
	iv_ruleXOtherOperatorExpression=ruleXOtherOperatorExpression
	{ $current=$iv_ruleXOtherOperatorExpression.current; }
	EOF;

// Rule XOtherOperatorExpression
ruleXOtherOperatorExpression returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXOtherOperatorExpression_XAdditiveExpressionParserRuleCall_0ElementType());
		}
		this_XAdditiveExpression_0=ruleXAdditiveExpression
		{
			$current = $this_XAdditiveExpression_0.current;
			doneComposite();
		}
		(
			(
				((
					(
					)
					(
						(
							ruleOpOther
						)
					)
				)
				)=>
				(
					(
						{
							precedeComposite(elementTypeProvider.getXOtherOperatorExpression_XBinaryOperationLeftOperandAction_1_0_0_0ElementType());
							doneComposite();
							associateWithSemanticElement();
						}
					)
					(
						(
							{
								if (!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
							{
								markComposite(elementTypeProvider.getXOtherOperatorExpression_FeatureJvmIdentifiableElementCrossReference_1_0_0_1_0ElementType());
							}
							ruleOpOther
							{
								doneComposite();
							}
						)
					)
				)
			)
			(
				(
					{
						markComposite(elementTypeProvider.getXOtherOperatorExpression_RightOperandXAdditiveExpressionParserRuleCall_1_1_0ElementType());
					}
					lv_rightOperand_3_0=ruleXAdditiveExpression
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)*
	)
;

//Entry rule entryRuleOpOther
entryRuleOpOther returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getOpOtherElementType()); }
	iv_ruleOpOther=ruleOpOther
	{ $current=$iv_ruleOpOther.current; }
	EOF;

// Rule OpOther
ruleOpOther returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getOpOther_HyphenMinusGreaterThanSignKeyword_0ElementType());
		}
		kw='->'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpOther_FullStopFullStopLessThanSignKeyword_1ElementType());
		}
		kw='..<'
		{
			doneLeaf(kw);
		}
		    |
		(
			{
				markLeaf(elementTypeProvider.getOpOther_GreaterThanSignKeyword_2_0ElementType());
			}
			kw='>'
			{
				doneLeaf(kw);
			}
			{
				markLeaf(elementTypeProvider.getOpOther_FullStopFullStopKeyword_2_1ElementType());
			}
			kw='..'
			{
				doneLeaf(kw);
			}
		)
		    |
		{
			markLeaf(elementTypeProvider.getOpOther_FullStopFullStopKeyword_3ElementType());
		}
		kw='..'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpOther_EqualsSignGreaterThanSignKeyword_4ElementType());
		}
		kw='=>'
		{
			doneLeaf(kw);
		}
		    |
		(
			{
				markLeaf(elementTypeProvider.getOpOther_GreaterThanSignKeyword_5_0ElementType());
			}
			kw='>'
			{
				doneLeaf(kw);
			}
			(
				(
					((
						'>'
						'>'
					)
					)=>
					(
						{
							markLeaf(elementTypeProvider.getOpOther_GreaterThanSignKeyword_5_1_0_0_0ElementType());
						}
						kw='>'
						{
							doneLeaf(kw);
						}
						{
							markLeaf(elementTypeProvider.getOpOther_GreaterThanSignKeyword_5_1_0_0_1ElementType());
						}
						kw='>'
						{
							doneLeaf(kw);
						}
					)
				)
				    |
				{
					markLeaf(elementTypeProvider.getOpOther_GreaterThanSignKeyword_5_1_1ElementType());
				}
				kw='>'
				{
					doneLeaf(kw);
				}
			)
		)
		    |
		(
			{
				markLeaf(elementTypeProvider.getOpOther_LessThanSignKeyword_6_0ElementType());
			}
			kw='<'
			{
				doneLeaf(kw);
			}
			(
				(
					((
						'<'
						'<'
					)
					)=>
					(
						{
							markLeaf(elementTypeProvider.getOpOther_LessThanSignKeyword_6_1_0_0_0ElementType());
						}
						kw='<'
						{
							doneLeaf(kw);
						}
						{
							markLeaf(elementTypeProvider.getOpOther_LessThanSignKeyword_6_1_0_0_1ElementType());
						}
						kw='<'
						{
							doneLeaf(kw);
						}
					)
				)
				    |
				{
					markLeaf(elementTypeProvider.getOpOther_LessThanSignKeyword_6_1_1ElementType());
				}
				kw='<'
				{
					doneLeaf(kw);
				}
				    |
				{
					markLeaf(elementTypeProvider.getOpOther_EqualsSignGreaterThanSignKeyword_6_1_2ElementType());
				}
				kw='=>'
				{
					doneLeaf(kw);
				}
			)
		)
		    |
		{
			markLeaf(elementTypeProvider.getOpOther_LessThanSignGreaterThanSignKeyword_7ElementType());
		}
		kw='<>'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpOther_QuestionMarkColonKeyword_8ElementType());
		}
		kw='?:'
		{
			doneLeaf(kw);
		}
	)
;

//Entry rule entryRuleXAdditiveExpression
entryRuleXAdditiveExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXAdditiveExpressionElementType()); }
	iv_ruleXAdditiveExpression=ruleXAdditiveExpression
	{ $current=$iv_ruleXAdditiveExpression.current; }
	EOF;

// Rule XAdditiveExpression
ruleXAdditiveExpression returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXAdditiveExpression_XMultiplicativeExpressionParserRuleCall_0ElementType());
		}
		this_XMultiplicativeExpression_0=ruleXMultiplicativeExpression
		{
			$current = $this_XMultiplicativeExpression_0.current;
			doneComposite();
		}
		(
			(
				((
					(
					)
					(
						(
							ruleOpAdd
						)
					)
				)
				)=>
				(
					(
						{
							precedeComposite(elementTypeProvider.getXAdditiveExpression_XBinaryOperationLeftOperandAction_1_0_0_0ElementType());
							doneComposite();
							associateWithSemanticElement();
						}
					)
					(
						(
							{
								if (!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
							{
								markComposite(elementTypeProvider.getXAdditiveExpression_FeatureJvmIdentifiableElementCrossReference_1_0_0_1_0ElementType());
							}
							ruleOpAdd
							{
								doneComposite();
							}
						)
					)
				)
			)
			(
				(
					{
						markComposite(elementTypeProvider.getXAdditiveExpression_RightOperandXMultiplicativeExpressionParserRuleCall_1_1_0ElementType());
					}
					lv_rightOperand_3_0=ruleXMultiplicativeExpression
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)*
	)
;

//Entry rule entryRuleOpAdd
entryRuleOpAdd returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getOpAddElementType()); }
	iv_ruleOpAdd=ruleOpAdd
	{ $current=$iv_ruleOpAdd.current; }
	EOF;

// Rule OpAdd
ruleOpAdd returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getOpAdd_PlusSignKeyword_0ElementType());
		}
		kw='+'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpAdd_HyphenMinusKeyword_1ElementType());
		}
		kw='-'
		{
			doneLeaf(kw);
		}
	)
;

//Entry rule entryRuleXMultiplicativeExpression
entryRuleXMultiplicativeExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXMultiplicativeExpressionElementType()); }
	iv_ruleXMultiplicativeExpression=ruleXMultiplicativeExpression
	{ $current=$iv_ruleXMultiplicativeExpression.current; }
	EOF;

// Rule XMultiplicativeExpression
ruleXMultiplicativeExpression returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXMultiplicativeExpression_XUnaryOperationParserRuleCall_0ElementType());
		}
		this_XUnaryOperation_0=ruleXUnaryOperation
		{
			$current = $this_XUnaryOperation_0.current;
			doneComposite();
		}
		(
			(
				((
					(
					)
					(
						(
							ruleOpMulti
						)
					)
				)
				)=>
				(
					(
						{
							precedeComposite(elementTypeProvider.getXMultiplicativeExpression_XBinaryOperationLeftOperandAction_1_0_0_0ElementType());
							doneComposite();
							associateWithSemanticElement();
						}
					)
					(
						(
							{
								if (!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
							{
								markComposite(elementTypeProvider.getXMultiplicativeExpression_FeatureJvmIdentifiableElementCrossReference_1_0_0_1_0ElementType());
							}
							ruleOpMulti
							{
								doneComposite();
							}
						)
					)
				)
			)
			(
				(
					{
						markComposite(elementTypeProvider.getXMultiplicativeExpression_RightOperandXUnaryOperationParserRuleCall_1_1_0ElementType());
					}
					lv_rightOperand_3_0=ruleXUnaryOperation
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)*
	)
;

//Entry rule entryRuleOpMulti
entryRuleOpMulti returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getOpMultiElementType()); }
	iv_ruleOpMulti=ruleOpMulti
	{ $current=$iv_ruleOpMulti.current; }
	EOF;

// Rule OpMulti
ruleOpMulti returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getOpMulti_AsteriskKeyword_0ElementType());
		}
		kw='*'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpMulti_AsteriskAsteriskKeyword_1ElementType());
		}
		kw='**'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpMulti_SolidusKeyword_2ElementType());
		}
		kw='/'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpMulti_PercentSignKeyword_3ElementType());
		}
		kw='%'
		{
			doneLeaf(kw);
		}
	)
;

//Entry rule entryRuleXUnaryOperation
entryRuleXUnaryOperation returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXUnaryOperationElementType()); }
	iv_ruleXUnaryOperation=ruleXUnaryOperation
	{ $current=$iv_ruleXUnaryOperation.current; }
	EOF;

// Rule XUnaryOperation
ruleXUnaryOperation returns [Boolean current=false]
:
	(
		(
			(
				{
					precedeComposite(elementTypeProvider.getXUnaryOperation_XUnaryOperationAction_0_0ElementType());
					doneComposite();
					associateWithSemanticElement();
				}
			)
			(
				(
					{
						if (!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
					{
						markComposite(elementTypeProvider.getXUnaryOperation_FeatureJvmIdentifiableElementCrossReference_0_1_0ElementType());
					}
					ruleOpUnary
					{
						doneComposite();
					}
				)
			)
			(
				(
					{
						markComposite(elementTypeProvider.getXUnaryOperation_OperandXUnaryOperationParserRuleCall_0_2_0ElementType());
					}
					lv_operand_2_0=ruleXUnaryOperation
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)
		    |
		{
			markComposite(elementTypeProvider.getXUnaryOperation_XCastedExpressionParserRuleCall_1ElementType());
		}
		this_XCastedExpression_3=ruleXCastedExpression
		{
			$current = $this_XCastedExpression_3.current;
			doneComposite();
		}
	)
;

//Entry rule entryRuleOpUnary
entryRuleOpUnary returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getOpUnaryElementType()); }
	iv_ruleOpUnary=ruleOpUnary
	{ $current=$iv_ruleOpUnary.current; }
	EOF;

// Rule OpUnary
ruleOpUnary returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getOpUnary_ExclamationMarkKeyword_0ElementType());
		}
		kw='!'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpUnary_HyphenMinusKeyword_1ElementType());
		}
		kw='-'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpUnary_PlusSignKeyword_2ElementType());
		}
		kw='+'
		{
			doneLeaf(kw);
		}
	)
;

//Entry rule entryRuleXCastedExpression
entryRuleXCastedExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXCastedExpressionElementType()); }
	iv_ruleXCastedExpression=ruleXCastedExpression
	{ $current=$iv_ruleXCastedExpression.current; }
	EOF;

// Rule XCastedExpression
ruleXCastedExpression returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXCastedExpression_XPostfixOperationParserRuleCall_0ElementType());
		}
		this_XPostfixOperation_0=ruleXPostfixOperation
		{
			$current = $this_XPostfixOperation_0.current;
			doneComposite();
		}
		(
			(
				((
					(
					)
					'as'
				)
				)=>
				(
					(
						{
							precedeComposite(elementTypeProvider.getXCastedExpression_XCastedExpressionTargetAction_1_0_0_0ElementType());
							doneComposite();
							associateWithSemanticElement();
						}
					)
					{
						markLeaf(elementTypeProvider.getXCastedExpression_AsKeyword_1_0_0_1ElementType());
					}
					otherlv_2='as'
					{
						doneLeaf(otherlv_2);
					}
				)
			)
			(
				(
					{
						markComposite(elementTypeProvider.getXCastedExpression_TypeJvmTypeReferenceParserRuleCall_1_1_0ElementType());
					}
					lv_type_3_0=ruleJvmTypeReference
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)*
	)
;

//Entry rule entryRuleXPostfixOperation
entryRuleXPostfixOperation returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXPostfixOperationElementType()); }
	iv_ruleXPostfixOperation=ruleXPostfixOperation
	{ $current=$iv_ruleXPostfixOperation.current; }
	EOF;

// Rule XPostfixOperation
ruleXPostfixOperation returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXPostfixOperation_XMemberFeatureCallParserRuleCall_0ElementType());
		}
		this_XMemberFeatureCall_0=ruleXMemberFeatureCall
		{
			$current = $this_XMemberFeatureCall_0.current;
			doneComposite();
		}
		(
			((
				(
				)
				(
					(
						ruleOpPostfix
					)
				)
			)
			)=>
			(
				(
					{
						precedeComposite(elementTypeProvider.getXPostfixOperation_XPostfixOperationOperandAction_1_0_0ElementType());
						doneComposite();
						associateWithSemanticElement();
					}
				)
				(
					(
						{
							if (!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
						{
							markComposite(elementTypeProvider.getXPostfixOperation_FeatureJvmIdentifiableElementCrossReference_1_0_1_0ElementType());
						}
						ruleOpPostfix
						{
							doneComposite();
						}
					)
				)
			)
		)?
	)
;

//Entry rule entryRuleOpPostfix
entryRuleOpPostfix returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getOpPostfixElementType()); }
	iv_ruleOpPostfix=ruleOpPostfix
	{ $current=$iv_ruleOpPostfix.current; }
	EOF;

// Rule OpPostfix
ruleOpPostfix returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getOpPostfix_PlusSignPlusSignKeyword_0ElementType());
		}
		kw='++'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getOpPostfix_HyphenMinusHyphenMinusKeyword_1ElementType());
		}
		kw='--'
		{
			doneLeaf(kw);
		}
	)
;

//Entry rule entryRuleXMemberFeatureCall
entryRuleXMemberFeatureCall returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXMemberFeatureCallElementType()); }
	iv_ruleXMemberFeatureCall=ruleXMemberFeatureCall
	{ $current=$iv_ruleXMemberFeatureCall.current; }
	EOF;

// Rule XMemberFeatureCall
ruleXMemberFeatureCall returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXMemberFeatureCall_XPrimaryExpressionParserRuleCall_0ElementType());
		}
		this_XPrimaryExpression_0=ruleXPrimaryExpression
		{
			$current = $this_XPrimaryExpression_0.current;
			doneComposite();
		}
		(
			(
				(
					((
						(
						)
						(
							'.'
							    |
							(
								(
									'::'
								)
							)
						)
						(
							(
								ruleFeatureCallID
							)
						)
						ruleOpSingleAssign
					)
					)=>
					(
						(
							{
								precedeComposite(elementTypeProvider.getXMemberFeatureCall_XAssignmentAssignableAction_1_0_0_0_0ElementType());
								doneComposite();
								associateWithSemanticElement();
							}
						)
						(
							{
								markLeaf(elementTypeProvider.getXMemberFeatureCall_FullStopKeyword_1_0_0_0_1_0ElementType());
							}
							otherlv_2='.'
							{
								doneLeaf(otherlv_2);
							}
							    |
							(
								(
									{
										markLeaf(elementTypeProvider.getXMemberFeatureCall_ExplicitStaticColonColonKeyword_1_0_0_0_1_1_0ElementType());
									}
									lv_explicitStatic_3_0='::'
									{
										doneLeaf(lv_explicitStatic_3_0);
									}
									{
										if (!$current) {
											associateWithSemanticElement();
											$current = true;
										}
									}
								)
							)
						)
						(
							(
								{
									if (!$current) {
										associateWithSemanticElement();
										$current = true;
									}
								}
								{
									markComposite(elementTypeProvider.getXMemberFeatureCall_FeatureJvmIdentifiableElementCrossReference_1_0_0_0_2_0ElementType());
								}
								ruleFeatureCallID
								{
									doneComposite();
								}
							)
						)
						{
							markComposite(elementTypeProvider.getXMemberFeatureCall_OpSingleAssignParserRuleCall_1_0_0_0_3ElementType());
						}
						ruleOpSingleAssign
						{
							doneComposite();
						}
					)
				)
				(
					(
						{
							markComposite(elementTypeProvider.getXMemberFeatureCall_ValueXAssignmentParserRuleCall_1_0_1_0ElementType());
						}
						lv_value_6_0=ruleXAssignment
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)
			    |
			(
				(
					((
						(
						)
						(
							'.'
							    |
							(
								(
									'?.'
								)
							)
							    |
							(
								(
									'::'
								)
							)
						)
					)
					)=>
					(
						(
							{
								precedeComposite(elementTypeProvider.getXMemberFeatureCall_XMemberFeatureCallMemberCallTargetAction_1_1_0_0_0ElementType());
								doneComposite();
								associateWithSemanticElement();
							}
						)
						(
							{
								markLeaf(elementTypeProvider.getXMemberFeatureCall_FullStopKeyword_1_1_0_0_1_0ElementType());
							}
							otherlv_8='.'
							{
								doneLeaf(otherlv_8);
							}
							    |
							(
								(
									{
										markLeaf(elementTypeProvider.getXMemberFeatureCall_NullSafeQuestionMarkFullStopKeyword_1_1_0_0_1_1_0ElementType());
									}
									lv_nullSafe_9_0='?.'
									{
										doneLeaf(lv_nullSafe_9_0);
									}
									{
										if (!$current) {
											associateWithSemanticElement();
											$current = true;
										}
									}
								)
							)
							    |
							(
								(
									{
										markLeaf(elementTypeProvider.getXMemberFeatureCall_ExplicitStaticColonColonKeyword_1_1_0_0_1_2_0ElementType());
									}
									lv_explicitStatic_10_0='::'
									{
										doneLeaf(lv_explicitStatic_10_0);
									}
									{
										if (!$current) {
											associateWithSemanticElement();
											$current = true;
										}
									}
								)
							)
						)
					)
				)
				(
					{
						markLeaf(elementTypeProvider.getXMemberFeatureCall_LessThanSignKeyword_1_1_1_0ElementType());
					}
					otherlv_11='<'
					{
						doneLeaf(otherlv_11);
					}
					(
						(
							{
								markComposite(elementTypeProvider.getXMemberFeatureCall_TypeArgumentsJvmArgumentTypeReferenceParserRuleCall_1_1_1_1_0ElementType());
							}
							lv_typeArguments_12_0=ruleJvmArgumentTypeReference
							{
								doneComposite();
								if(!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
					(
						{
							markLeaf(elementTypeProvider.getXMemberFeatureCall_CommaKeyword_1_1_1_2_0ElementType());
						}
						otherlv_13=','
						{
							doneLeaf(otherlv_13);
						}
						(
							(
								{
									markComposite(elementTypeProvider.getXMemberFeatureCall_TypeArgumentsJvmArgumentTypeReferenceParserRuleCall_1_1_1_2_1_0ElementType());
								}
								lv_typeArguments_14_0=ruleJvmArgumentTypeReference
								{
									doneComposite();
									if(!$current) {
										associateWithSemanticElement();
										$current = true;
									}
								}
							)
						)
					)*
					{
						markLeaf(elementTypeProvider.getXMemberFeatureCall_GreaterThanSignKeyword_1_1_1_3ElementType());
					}
					otherlv_15='>'
					{
						doneLeaf(otherlv_15);
					}
				)?
				(
					(
						{
							if (!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
						{
							markComposite(elementTypeProvider.getXMemberFeatureCall_FeatureJvmIdentifiableElementCrossReference_1_1_2_0ElementType());
						}
						ruleIdOrSuper
						{
							doneComposite();
						}
					)
				)
				(
					(
						((
							'('
						)
						)=>
						(
							{
								markLeaf(elementTypeProvider.getXMemberFeatureCall_ExplicitOperationCallLeftParenthesisKeyword_1_1_3_0_0ElementType());
							}
							lv_explicitOperationCall_17_0='('
							{
								doneLeaf(lv_explicitOperationCall_17_0);
							}
							{
								if (!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
					(
						(
							((
								(
								)
								(
									(
										(
											ruleJvmFormalParameter
										)
									)
									(
										','
										(
											(
												ruleJvmFormalParameter
											)
										)
									)*
								)?
								(
									(
										'|'
									)
								)
							)
							)=>
							(
								{
									markComposite(elementTypeProvider.getXMemberFeatureCall_MemberCallArgumentsXShortClosureParserRuleCall_1_1_3_1_0_0ElementType());
								}
								lv_memberCallArguments_18_0=ruleXShortClosure
								{
									doneComposite();
									if(!$current) {
										associateWithSemanticElement();
										$current = true;
									}
								}
							)
						)
						    |
						(
							(
								(
									{
										markComposite(elementTypeProvider.getXMemberFeatureCall_MemberCallArgumentsXExpressionParserRuleCall_1_1_3_1_1_0_0ElementType());
									}
									lv_memberCallArguments_19_0=ruleXExpression
									{
										doneComposite();
										if(!$current) {
											associateWithSemanticElement();
											$current = true;
										}
									}
								)
							)
							(
								{
									markLeaf(elementTypeProvider.getXMemberFeatureCall_CommaKeyword_1_1_3_1_1_1_0ElementType());
								}
								otherlv_20=','
								{
									doneLeaf(otherlv_20);
								}
								(
									(
										{
											markComposite(elementTypeProvider.getXMemberFeatureCall_MemberCallArgumentsXExpressionParserRuleCall_1_1_3_1_1_1_1_0ElementType());
										}
										lv_memberCallArguments_21_0=ruleXExpression
										{
											doneComposite();
											if(!$current) {
												associateWithSemanticElement();
												$current = true;
											}
										}
									)
								)
							)*
						)
					)?
					{
						markLeaf(elementTypeProvider.getXMemberFeatureCall_RightParenthesisKeyword_1_1_3_2ElementType());
					}
					otherlv_22=')'
					{
						doneLeaf(otherlv_22);
					}
				)?
				(
					((
						(
						)
						'['
					)
					)=>
					(
						{
							markComposite(elementTypeProvider.getXMemberFeatureCall_MemberCallArgumentsXClosureParserRuleCall_1_1_4_0ElementType());
						}
						lv_memberCallArguments_23_0=ruleXClosure
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)?
			)
		)*
	)
;

//Entry rule entryRuleXPrimaryExpression
entryRuleXPrimaryExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXPrimaryExpressionElementType()); }
	iv_ruleXPrimaryExpression=ruleXPrimaryExpression
	{ $current=$iv_ruleXPrimaryExpression.current; }
	EOF;

// Rule XPrimaryExpression
ruleXPrimaryExpression returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XConstructorCallParserRuleCall_0ElementType());
		}
		this_XConstructorCall_0=ruleXConstructorCall
		{
			$current = $this_XConstructorCall_0.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XBlockExpressionParserRuleCall_1ElementType());
		}
		this_XBlockExpression_1=ruleXBlockExpression
		{
			$current = $this_XBlockExpression_1.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XSwitchExpressionParserRuleCall_2ElementType());
		}
		this_XSwitchExpression_2=ruleXSwitchExpression
		{
			$current = $this_XSwitchExpression_2.current;
			doneComposite();
		}
		    |
		(
			((
				(
				)
				'synchronized'
				'('
			)
			)=>
			{
				markComposite(elementTypeProvider.getXPrimaryExpression_XSynchronizedExpressionParserRuleCall_3ElementType());
			}
			this_XSynchronizedExpression_3=ruleXSynchronizedExpression
			{
				$current = $this_XSynchronizedExpression_3.current;
				doneComposite();
			}
		)
		    |
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XFeatureCallParserRuleCall_4ElementType());
		}
		this_XFeatureCall_4=ruleXFeatureCall
		{
			$current = $this_XFeatureCall_4.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XLiteralParserRuleCall_5ElementType());
		}
		this_XLiteral_5=ruleXLiteral
		{
			$current = $this_XLiteral_5.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XIfExpressionParserRuleCall_6ElementType());
		}
		this_XIfExpression_6=ruleXIfExpression
		{
			$current = $this_XIfExpression_6.current;
			doneComposite();
		}
		    |
		(
			((
				(
				)
				'for'
				'('
				(
					(
						ruleJvmFormalParameter
					)
				)
				':'
			)
			)=>
			{
				markComposite(elementTypeProvider.getXPrimaryExpression_XForLoopExpressionParserRuleCall_7ElementType());
			}
			this_XForLoopExpression_7=ruleXForLoopExpression
			{
				$current = $this_XForLoopExpression_7.current;
				doneComposite();
			}
		)
		    |
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XBasicForLoopExpressionParserRuleCall_8ElementType());
		}
		this_XBasicForLoopExpression_8=ruleXBasicForLoopExpression
		{
			$current = $this_XBasicForLoopExpression_8.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XWhileExpressionParserRuleCall_9ElementType());
		}
		this_XWhileExpression_9=ruleXWhileExpression
		{
			$current = $this_XWhileExpression_9.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XDoWhileExpressionParserRuleCall_10ElementType());
		}
		this_XDoWhileExpression_10=ruleXDoWhileExpression
		{
			$current = $this_XDoWhileExpression_10.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XThrowExpressionParserRuleCall_11ElementType());
		}
		this_XThrowExpression_11=ruleXThrowExpression
		{
			$current = $this_XThrowExpression_11.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XReturnExpressionParserRuleCall_12ElementType());
		}
		this_XReturnExpression_12=ruleXReturnExpression
		{
			$current = $this_XReturnExpression_12.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XTryCatchFinallyExpressionParserRuleCall_13ElementType());
		}
		this_XTryCatchFinallyExpression_13=ruleXTryCatchFinallyExpression
		{
			$current = $this_XTryCatchFinallyExpression_13.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXPrimaryExpression_XParenthesizedExpressionParserRuleCall_14ElementType());
		}
		this_XParenthesizedExpression_14=ruleXParenthesizedExpression
		{
			$current = $this_XParenthesizedExpression_14.current;
			doneComposite();
		}
	)
;

//Entry rule entryRuleXLiteral
entryRuleXLiteral returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXLiteralElementType()); }
	iv_ruleXLiteral=ruleXLiteral
	{ $current=$iv_ruleXLiteral.current; }
	EOF;

// Rule XLiteral
ruleXLiteral returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXLiteral_XCollectionLiteralParserRuleCall_0ElementType());
		}
		this_XCollectionLiteral_0=ruleXCollectionLiteral
		{
			$current = $this_XCollectionLiteral_0.current;
			doneComposite();
		}
		    |
		(
			((
				(
				)
				'['
			)
			)=>
			{
				markComposite(elementTypeProvider.getXLiteral_XClosureParserRuleCall_1ElementType());
			}
			this_XClosure_1=ruleXClosure
			{
				$current = $this_XClosure_1.current;
				doneComposite();
			}
		)
		    |
		{
			markComposite(elementTypeProvider.getXLiteral_XBooleanLiteralParserRuleCall_2ElementType());
		}
		this_XBooleanLiteral_2=ruleXBooleanLiteral
		{
			$current = $this_XBooleanLiteral_2.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXLiteral_XNumberLiteralParserRuleCall_3ElementType());
		}
		this_XNumberLiteral_3=ruleXNumberLiteral
		{
			$current = $this_XNumberLiteral_3.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXLiteral_XNullLiteralParserRuleCall_4ElementType());
		}
		this_XNullLiteral_4=ruleXNullLiteral
		{
			$current = $this_XNullLiteral_4.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXLiteral_XStringLiteralParserRuleCall_5ElementType());
		}
		this_XStringLiteral_5=ruleXStringLiteral
		{
			$current = $this_XStringLiteral_5.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXLiteral_XTypeLiteralParserRuleCall_6ElementType());
		}
		this_XTypeLiteral_6=ruleXTypeLiteral
		{
			$current = $this_XTypeLiteral_6.current;
			doneComposite();
		}
	)
;

//Entry rule entryRuleXCollectionLiteral
entryRuleXCollectionLiteral returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXCollectionLiteralElementType()); }
	iv_ruleXCollectionLiteral=ruleXCollectionLiteral
	{ $current=$iv_ruleXCollectionLiteral.current; }
	EOF;

// Rule XCollectionLiteral
ruleXCollectionLiteral returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXCollectionLiteral_XSetLiteralParserRuleCall_0ElementType());
		}
		this_XSetLiteral_0=ruleXSetLiteral
		{
			$current = $this_XSetLiteral_0.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXCollectionLiteral_XListLiteralParserRuleCall_1ElementType());
		}
		this_XListLiteral_1=ruleXListLiteral
		{
			$current = $this_XListLiteral_1.current;
			doneComposite();
		}
	)
;

//Entry rule entryRuleXSetLiteral
entryRuleXSetLiteral returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXSetLiteralElementType()); }
	iv_ruleXSetLiteral=ruleXSetLiteral
	{ $current=$iv_ruleXSetLiteral.current; }
	EOF;

// Rule XSetLiteral
ruleXSetLiteral returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXSetLiteral_XSetLiteralAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXSetLiteral_NumberSignKeyword_1ElementType());
		}
		otherlv_1='#'
		{
			doneLeaf(otherlv_1);
		}
		{
			markLeaf(elementTypeProvider.getXSetLiteral_LeftCurlyBracketKeyword_2ElementType());
		}
		otherlv_2='{'
		{
			doneLeaf(otherlv_2);
		}
		(
			(
				(
					{
						markComposite(elementTypeProvider.getXSetLiteral_ElementsXExpressionParserRuleCall_3_0_0ElementType());
					}
					lv_elements_3_0=ruleXExpression
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			(
				{
					markLeaf(elementTypeProvider.getXSetLiteral_CommaKeyword_3_1_0ElementType());
				}
				otherlv_4=','
				{
					doneLeaf(otherlv_4);
				}
				(
					(
						{
							markComposite(elementTypeProvider.getXSetLiteral_ElementsXExpressionParserRuleCall_3_1_1_0ElementType());
						}
						lv_elements_5_0=ruleXExpression
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)*
		)?
		{
			markLeaf(elementTypeProvider.getXSetLiteral_RightCurlyBracketKeyword_4ElementType());
		}
		otherlv_6='}'
		{
			doneLeaf(otherlv_6);
		}
	)
;

//Entry rule entryRuleXListLiteral
entryRuleXListLiteral returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXListLiteralElementType()); }
	iv_ruleXListLiteral=ruleXListLiteral
	{ $current=$iv_ruleXListLiteral.current; }
	EOF;

// Rule XListLiteral
ruleXListLiteral returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXListLiteral_XListLiteralAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXListLiteral_NumberSignKeyword_1ElementType());
		}
		otherlv_1='#'
		{
			doneLeaf(otherlv_1);
		}
		{
			markLeaf(elementTypeProvider.getXListLiteral_LeftSquareBracketKeyword_2ElementType());
		}
		otherlv_2='['
		{
			doneLeaf(otherlv_2);
		}
		(
			(
				(
					{
						markComposite(elementTypeProvider.getXListLiteral_ElementsXExpressionParserRuleCall_3_0_0ElementType());
					}
					lv_elements_3_0=ruleXExpression
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			(
				{
					markLeaf(elementTypeProvider.getXListLiteral_CommaKeyword_3_1_0ElementType());
				}
				otherlv_4=','
				{
					doneLeaf(otherlv_4);
				}
				(
					(
						{
							markComposite(elementTypeProvider.getXListLiteral_ElementsXExpressionParserRuleCall_3_1_1_0ElementType());
						}
						lv_elements_5_0=ruleXExpression
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)*
		)?
		{
			markLeaf(elementTypeProvider.getXListLiteral_RightSquareBracketKeyword_4ElementType());
		}
		otherlv_6=']'
		{
			doneLeaf(otherlv_6);
		}
	)
;

//Entry rule entryRuleXClosure
entryRuleXClosure returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXClosureElementType()); }
	iv_ruleXClosure=ruleXClosure
	{ $current=$iv_ruleXClosure.current; }
	EOF;

// Rule XClosure
ruleXClosure returns [Boolean current=false]
:
	(
		(
			((
				(
				)
				'['
			)
			)=>
			(
				(
					{
						precedeComposite(elementTypeProvider.getXClosure_XClosureAction_0_0_0ElementType());
						doneComposite();
						associateWithSemanticElement();
					}
				)
				{
					markLeaf(elementTypeProvider.getXClosure_LeftSquareBracketKeyword_0_0_1ElementType());
				}
				otherlv_1='['
				{
					doneLeaf(otherlv_1);
				}
			)
		)
		(
			((
				(
					(
						(
							ruleJvmFormalParameter
						)
					)
					(
						','
						(
							(
								ruleJvmFormalParameter
							)
						)
					)*
				)?
				(
					(
						'|'
					)
				)
			)
			)=>
			(
				(
					(
						(
							{
								markComposite(elementTypeProvider.getXClosure_DeclaredFormalParametersJvmFormalParameterParserRuleCall_1_0_0_0_0ElementType());
							}
							lv_declaredFormalParameters_2_0=ruleJvmFormalParameter
							{
								doneComposite();
								if(!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
					(
						{
							markLeaf(elementTypeProvider.getXClosure_CommaKeyword_1_0_0_1_0ElementType());
						}
						otherlv_3=','
						{
							doneLeaf(otherlv_3);
						}
						(
							(
								{
									markComposite(elementTypeProvider.getXClosure_DeclaredFormalParametersJvmFormalParameterParserRuleCall_1_0_0_1_1_0ElementType());
								}
								lv_declaredFormalParameters_4_0=ruleJvmFormalParameter
								{
									doneComposite();
									if(!$current) {
										associateWithSemanticElement();
										$current = true;
									}
								}
							)
						)
					)*
				)?
				(
					(
						{
							markLeaf(elementTypeProvider.getXClosure_ExplicitSyntaxVerticalLineKeyword_1_0_1_0ElementType());
						}
						lv_explicitSyntax_5_0='|'
						{
							doneLeaf(lv_explicitSyntax_5_0);
						}
						{
							if (!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)
		)?
		(
			(
				{
					markComposite(elementTypeProvider.getXClosure_ExpressionXExpressionInClosureParserRuleCall_2_0ElementType());
				}
				lv_expression_6_0=ruleXExpressionInClosure
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		{
			markLeaf(elementTypeProvider.getXClosure_RightSquareBracketKeyword_3ElementType());
		}
		otherlv_7=']'
		{
			doneLeaf(otherlv_7);
		}
	)
;

//Entry rule entryRuleXExpressionInClosure
entryRuleXExpressionInClosure returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXExpressionInClosureElementType()); }
	iv_ruleXExpressionInClosure=ruleXExpressionInClosure
	{ $current=$iv_ruleXExpressionInClosure.current; }
	EOF;

// Rule XExpressionInClosure
ruleXExpressionInClosure returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXExpressionInClosure_XBlockExpressionAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		(
			(
				(
					{
						markComposite(elementTypeProvider.getXExpressionInClosure_ExpressionsXExpressionOrVarDeclarationParserRuleCall_1_0_0ElementType());
					}
					lv_expressions_1_0=ruleXExpressionOrVarDeclaration
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			(
				{
					markLeaf(elementTypeProvider.getXExpressionInClosure_SemicolonKeyword_1_1ElementType());
				}
				otherlv_2=';'
				{
					doneLeaf(otherlv_2);
				}
			)?
		)*
	)
;

//Entry rule entryRuleXShortClosure
entryRuleXShortClosure returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXShortClosureElementType()); }
	iv_ruleXShortClosure=ruleXShortClosure
	{ $current=$iv_ruleXShortClosure.current; }
	EOF;

// Rule XShortClosure
ruleXShortClosure returns [Boolean current=false]
:
	(
		(
			((
				(
				)
				(
					(
						(
							ruleJvmFormalParameter
						)
					)
					(
						','
						(
							(
								ruleJvmFormalParameter
							)
						)
					)*
				)?
				(
					(
						'|'
					)
				)
			)
			)=>
			(
				(
					{
						precedeComposite(elementTypeProvider.getXShortClosure_XClosureAction_0_0_0ElementType());
						doneComposite();
						associateWithSemanticElement();
					}
				)
				(
					(
						(
							{
								markComposite(elementTypeProvider.getXShortClosure_DeclaredFormalParametersJvmFormalParameterParserRuleCall_0_0_1_0_0ElementType());
							}
							lv_declaredFormalParameters_1_0=ruleJvmFormalParameter
							{
								doneComposite();
								if(!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
					(
						{
							markLeaf(elementTypeProvider.getXShortClosure_CommaKeyword_0_0_1_1_0ElementType());
						}
						otherlv_2=','
						{
							doneLeaf(otherlv_2);
						}
						(
							(
								{
									markComposite(elementTypeProvider.getXShortClosure_DeclaredFormalParametersJvmFormalParameterParserRuleCall_0_0_1_1_1_0ElementType());
								}
								lv_declaredFormalParameters_3_0=ruleJvmFormalParameter
								{
									doneComposite();
									if(!$current) {
										associateWithSemanticElement();
										$current = true;
									}
								}
							)
						)
					)*
				)?
				(
					(
						{
							markLeaf(elementTypeProvider.getXShortClosure_ExplicitSyntaxVerticalLineKeyword_0_0_2_0ElementType());
						}
						lv_explicitSyntax_4_0='|'
						{
							doneLeaf(lv_explicitSyntax_4_0);
						}
						{
							if (!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)
		)
		(
			(
				{
					markComposite(elementTypeProvider.getXShortClosure_ExpressionXExpressionParserRuleCall_1_0ElementType());
				}
				lv_expression_5_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleXParenthesizedExpression
entryRuleXParenthesizedExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXParenthesizedExpressionElementType()); }
	iv_ruleXParenthesizedExpression=ruleXParenthesizedExpression
	{ $current=$iv_ruleXParenthesizedExpression.current; }
	EOF;

// Rule XParenthesizedExpression
ruleXParenthesizedExpression returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getXParenthesizedExpression_LeftParenthesisKeyword_0ElementType());
		}
		otherlv_0='('
		{
			doneLeaf(otherlv_0);
		}
		{
			markComposite(elementTypeProvider.getXParenthesizedExpression_XExpressionParserRuleCall_1ElementType());
		}
		this_XExpression_1=ruleXExpression
		{
			$current = $this_XExpression_1.current;
			doneComposite();
		}
		{
			markLeaf(elementTypeProvider.getXParenthesizedExpression_RightParenthesisKeyword_2ElementType());
		}
		otherlv_2=')'
		{
			doneLeaf(otherlv_2);
		}
	)
;

//Entry rule entryRuleXIfExpression
entryRuleXIfExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXIfExpressionElementType()); }
	iv_ruleXIfExpression=ruleXIfExpression
	{ $current=$iv_ruleXIfExpression.current; }
	EOF;

// Rule XIfExpression
ruleXIfExpression returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXIfExpression_XIfExpressionAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXIfExpression_IfKeyword_1ElementType());
		}
		otherlv_1='if'
		{
			doneLeaf(otherlv_1);
		}
		{
			markLeaf(elementTypeProvider.getXIfExpression_LeftParenthesisKeyword_2ElementType());
		}
		otherlv_2='('
		{
			doneLeaf(otherlv_2);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXIfExpression_IfXExpressionParserRuleCall_3_0ElementType());
				}
				lv_if_3_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		{
			markLeaf(elementTypeProvider.getXIfExpression_RightParenthesisKeyword_4ElementType());
		}
		otherlv_4=')'
		{
			doneLeaf(otherlv_4);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXIfExpression_ThenXExpressionParserRuleCall_5_0ElementType());
				}
				lv_then_5_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		(
			(
				('else')=>
				{
					markLeaf(elementTypeProvider.getXIfExpression_ElseKeyword_6_0ElementType());
				}
				otherlv_6='else'
				{
					doneLeaf(otherlv_6);
				}
			)
			(
				(
					{
						markComposite(elementTypeProvider.getXIfExpression_ElseXExpressionParserRuleCall_6_1_0ElementType());
					}
					lv_else_7_0=ruleXExpression
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)?
	)
;

//Entry rule entryRuleXSwitchExpression
entryRuleXSwitchExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXSwitchExpressionElementType()); }
	iv_ruleXSwitchExpression=ruleXSwitchExpression
	{ $current=$iv_ruleXSwitchExpression.current; }
	EOF;

// Rule XSwitchExpression
ruleXSwitchExpression returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXSwitchExpression_XSwitchExpressionAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXSwitchExpression_SwitchKeyword_1ElementType());
		}
		otherlv_1='switch'
		{
			doneLeaf(otherlv_1);
		}
		(
			(
				(
					((
						'('
						(
							(
								ruleJvmFormalParameter
							)
						)
						':'
					)
					)=>
					(
						{
							markLeaf(elementTypeProvider.getXSwitchExpression_LeftParenthesisKeyword_2_0_0_0_0ElementType());
						}
						otherlv_2='('
						{
							doneLeaf(otherlv_2);
						}
						(
							(
								{
									markComposite(elementTypeProvider.getXSwitchExpression_DeclaredParamJvmFormalParameterParserRuleCall_2_0_0_0_1_0ElementType());
								}
								lv_declaredParam_3_0=ruleJvmFormalParameter
								{
									doneComposite();
									if(!$current) {
										associateWithSemanticElement();
										$current = true;
									}
								}
							)
						)
						{
							markLeaf(elementTypeProvider.getXSwitchExpression_ColonKeyword_2_0_0_0_2ElementType());
						}
						otherlv_4=':'
						{
							doneLeaf(otherlv_4);
						}
					)
				)
				(
					(
						{
							markComposite(elementTypeProvider.getXSwitchExpression_SwitchXExpressionParserRuleCall_2_0_1_0ElementType());
						}
						lv_switch_5_0=ruleXExpression
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
				{
					markLeaf(elementTypeProvider.getXSwitchExpression_RightParenthesisKeyword_2_0_2ElementType());
				}
				otherlv_6=')'
				{
					doneLeaf(otherlv_6);
				}
			)
			    |
			(
				(
					((
						(
							(
								ruleJvmFormalParameter
							)
						)
						':'
					)
					)=>
					(
						(
							(
								{
									markComposite(elementTypeProvider.getXSwitchExpression_DeclaredParamJvmFormalParameterParserRuleCall_2_1_0_0_0_0ElementType());
								}
								lv_declaredParam_7_0=ruleJvmFormalParameter
								{
									doneComposite();
									if(!$current) {
										associateWithSemanticElement();
										$current = true;
									}
								}
							)
						)
						{
							markLeaf(elementTypeProvider.getXSwitchExpression_ColonKeyword_2_1_0_0_1ElementType());
						}
						otherlv_8=':'
						{
							doneLeaf(otherlv_8);
						}
					)
				)?
				(
					(
						{
							markComposite(elementTypeProvider.getXSwitchExpression_SwitchXExpressionParserRuleCall_2_1_1_0ElementType());
						}
						lv_switch_9_0=ruleXExpression
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)
		)
		{
			markLeaf(elementTypeProvider.getXSwitchExpression_LeftCurlyBracketKeyword_3ElementType());
		}
		otherlv_10='{'
		{
			doneLeaf(otherlv_10);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXSwitchExpression_CasesXCasePartParserRuleCall_4_0ElementType());
				}
				lv_cases_11_0=ruleXCasePart
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)*
		(
			{
				markLeaf(elementTypeProvider.getXSwitchExpression_DefaultKeyword_5_0ElementType());
			}
			otherlv_12='default'
			{
				doneLeaf(otherlv_12);
			}
			{
				markLeaf(elementTypeProvider.getXSwitchExpression_ColonKeyword_5_1ElementType());
			}
			otherlv_13=':'
			{
				doneLeaf(otherlv_13);
			}
			(
				(
					{
						markComposite(elementTypeProvider.getXSwitchExpression_DefaultXExpressionParserRuleCall_5_2_0ElementType());
					}
					lv_default_14_0=ruleXExpression
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)?
		{
			markLeaf(elementTypeProvider.getXSwitchExpression_RightCurlyBracketKeyword_6ElementType());
		}
		otherlv_15='}'
		{
			doneLeaf(otherlv_15);
		}
	)
;

//Entry rule entryRuleXCasePart
entryRuleXCasePart returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXCasePartElementType()); }
	iv_ruleXCasePart=ruleXCasePart
	{ $current=$iv_ruleXCasePart.current; }
	EOF;

// Rule XCasePart
ruleXCasePart returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXCasePart_XCasePartAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		(
			(
				{
					markComposite(elementTypeProvider.getXCasePart_TypeGuardJvmTypeReferenceParserRuleCall_1_0ElementType());
				}
				lv_typeGuard_1_0=ruleJvmTypeReference
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)?
		(
			{
				markLeaf(elementTypeProvider.getXCasePart_CaseKeyword_2_0ElementType());
			}
			otherlv_2='case'
			{
				doneLeaf(otherlv_2);
			}
			(
				(
					{
						markComposite(elementTypeProvider.getXCasePart_CaseXExpressionParserRuleCall_2_1_0ElementType());
					}
					lv_case_3_0=ruleXExpression
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)?
		(
			(
				{
					markLeaf(elementTypeProvider.getXCasePart_ColonKeyword_3_0_0ElementType());
				}
				otherlv_4=':'
				{
					doneLeaf(otherlv_4);
				}
				(
					(
						{
							markComposite(elementTypeProvider.getXCasePart_ThenXExpressionParserRuleCall_3_0_1_0ElementType());
						}
						lv_then_5_0=ruleXExpression
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)
			    |
			(
				(
					{
						markLeaf(elementTypeProvider.getXCasePart_FallThroughCommaKeyword_3_1_0ElementType());
					}
					lv_fallThrough_6_0=','
					{
						doneLeaf(lv_fallThrough_6_0);
					}
					{
						if (!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)
	)
;

//Entry rule entryRuleXForLoopExpression
entryRuleXForLoopExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXForLoopExpressionElementType()); }
	iv_ruleXForLoopExpression=ruleXForLoopExpression
	{ $current=$iv_ruleXForLoopExpression.current; }
	EOF;

// Rule XForLoopExpression
ruleXForLoopExpression returns [Boolean current=false]
:
	(
		(
			((
				(
				)
				'for'
				'('
				(
					(
						ruleJvmFormalParameter
					)
				)
				':'
			)
			)=>
			(
				(
					{
						precedeComposite(elementTypeProvider.getXForLoopExpression_XForLoopExpressionAction_0_0_0ElementType());
						doneComposite();
						associateWithSemanticElement();
					}
				)
				{
					markLeaf(elementTypeProvider.getXForLoopExpression_ForKeyword_0_0_1ElementType());
				}
				otherlv_1='for'
				{
					doneLeaf(otherlv_1);
				}
				{
					markLeaf(elementTypeProvider.getXForLoopExpression_LeftParenthesisKeyword_0_0_2ElementType());
				}
				otherlv_2='('
				{
					doneLeaf(otherlv_2);
				}
				(
					(
						{
							markComposite(elementTypeProvider.getXForLoopExpression_DeclaredParamJvmFormalParameterParserRuleCall_0_0_3_0ElementType());
						}
						lv_declaredParam_3_0=ruleJvmFormalParameter
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
				{
					markLeaf(elementTypeProvider.getXForLoopExpression_ColonKeyword_0_0_4ElementType());
				}
				otherlv_4=':'
				{
					doneLeaf(otherlv_4);
				}
			)
		)
		(
			(
				{
					markComposite(elementTypeProvider.getXForLoopExpression_ForExpressionXExpressionParserRuleCall_1_0ElementType());
				}
				lv_forExpression_5_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		{
			markLeaf(elementTypeProvider.getXForLoopExpression_RightParenthesisKeyword_2ElementType());
		}
		otherlv_6=')'
		{
			doneLeaf(otherlv_6);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXForLoopExpression_EachExpressionXExpressionParserRuleCall_3_0ElementType());
				}
				lv_eachExpression_7_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleXBasicForLoopExpression
entryRuleXBasicForLoopExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXBasicForLoopExpressionElementType()); }
	iv_ruleXBasicForLoopExpression=ruleXBasicForLoopExpression
	{ $current=$iv_ruleXBasicForLoopExpression.current; }
	EOF;

// Rule XBasicForLoopExpression
ruleXBasicForLoopExpression returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXBasicForLoopExpression_XBasicForLoopExpressionAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXBasicForLoopExpression_ForKeyword_1ElementType());
		}
		otherlv_1='for'
		{
			doneLeaf(otherlv_1);
		}
		{
			markLeaf(elementTypeProvider.getXBasicForLoopExpression_LeftParenthesisKeyword_2ElementType());
		}
		otherlv_2='('
		{
			doneLeaf(otherlv_2);
		}
		(
			(
				(
					{
						markComposite(elementTypeProvider.getXBasicForLoopExpression_InitExpressionsXExpressionOrVarDeclarationParserRuleCall_3_0_0ElementType());
					}
					lv_initExpressions_3_0=ruleXExpressionOrVarDeclaration
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			(
				{
					markLeaf(elementTypeProvider.getXBasicForLoopExpression_CommaKeyword_3_1_0ElementType());
				}
				otherlv_4=','
				{
					doneLeaf(otherlv_4);
				}
				(
					(
						{
							markComposite(elementTypeProvider.getXBasicForLoopExpression_InitExpressionsXExpressionOrVarDeclarationParserRuleCall_3_1_1_0ElementType());
						}
						lv_initExpressions_5_0=ruleXExpressionOrVarDeclaration
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)*
		)?
		{
			markLeaf(elementTypeProvider.getXBasicForLoopExpression_SemicolonKeyword_4ElementType());
		}
		otherlv_6=';'
		{
			doneLeaf(otherlv_6);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXBasicForLoopExpression_ExpressionXExpressionParserRuleCall_5_0ElementType());
				}
				lv_expression_7_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)?
		{
			markLeaf(elementTypeProvider.getXBasicForLoopExpression_SemicolonKeyword_6ElementType());
		}
		otherlv_8=';'
		{
			doneLeaf(otherlv_8);
		}
		(
			(
				(
					{
						markComposite(elementTypeProvider.getXBasicForLoopExpression_UpdateExpressionsXExpressionParserRuleCall_7_0_0ElementType());
					}
					lv_updateExpressions_9_0=ruleXExpression
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			(
				{
					markLeaf(elementTypeProvider.getXBasicForLoopExpression_CommaKeyword_7_1_0ElementType());
				}
				otherlv_10=','
				{
					doneLeaf(otherlv_10);
				}
				(
					(
						{
							markComposite(elementTypeProvider.getXBasicForLoopExpression_UpdateExpressionsXExpressionParserRuleCall_7_1_1_0ElementType());
						}
						lv_updateExpressions_11_0=ruleXExpression
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)*
		)?
		{
			markLeaf(elementTypeProvider.getXBasicForLoopExpression_RightParenthesisKeyword_8ElementType());
		}
		otherlv_12=')'
		{
			doneLeaf(otherlv_12);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXBasicForLoopExpression_EachExpressionXExpressionParserRuleCall_9_0ElementType());
				}
				lv_eachExpression_13_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleXWhileExpression
entryRuleXWhileExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXWhileExpressionElementType()); }
	iv_ruleXWhileExpression=ruleXWhileExpression
	{ $current=$iv_ruleXWhileExpression.current; }
	EOF;

// Rule XWhileExpression
ruleXWhileExpression returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXWhileExpression_XWhileExpressionAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXWhileExpression_WhileKeyword_1ElementType());
		}
		otherlv_1='while'
		{
			doneLeaf(otherlv_1);
		}
		{
			markLeaf(elementTypeProvider.getXWhileExpression_LeftParenthesisKeyword_2ElementType());
		}
		otherlv_2='('
		{
			doneLeaf(otherlv_2);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXWhileExpression_PredicateXExpressionParserRuleCall_3_0ElementType());
				}
				lv_predicate_3_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		{
			markLeaf(elementTypeProvider.getXWhileExpression_RightParenthesisKeyword_4ElementType());
		}
		otherlv_4=')'
		{
			doneLeaf(otherlv_4);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXWhileExpression_BodyXExpressionParserRuleCall_5_0ElementType());
				}
				lv_body_5_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleXDoWhileExpression
entryRuleXDoWhileExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXDoWhileExpressionElementType()); }
	iv_ruleXDoWhileExpression=ruleXDoWhileExpression
	{ $current=$iv_ruleXDoWhileExpression.current; }
	EOF;

// Rule XDoWhileExpression
ruleXDoWhileExpression returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXDoWhileExpression_XDoWhileExpressionAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXDoWhileExpression_DoKeyword_1ElementType());
		}
		otherlv_1='do'
		{
			doneLeaf(otherlv_1);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXDoWhileExpression_BodyXExpressionParserRuleCall_2_0ElementType());
				}
				lv_body_2_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		{
			markLeaf(elementTypeProvider.getXDoWhileExpression_WhileKeyword_3ElementType());
		}
		otherlv_3='while'
		{
			doneLeaf(otherlv_3);
		}
		{
			markLeaf(elementTypeProvider.getXDoWhileExpression_LeftParenthesisKeyword_4ElementType());
		}
		otherlv_4='('
		{
			doneLeaf(otherlv_4);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXDoWhileExpression_PredicateXExpressionParserRuleCall_5_0ElementType());
				}
				lv_predicate_5_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		{
			markLeaf(elementTypeProvider.getXDoWhileExpression_RightParenthesisKeyword_6ElementType());
		}
		otherlv_6=')'
		{
			doneLeaf(otherlv_6);
		}
	)
;

//Entry rule entryRuleXBlockExpression
entryRuleXBlockExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXBlockExpressionElementType()); }
	iv_ruleXBlockExpression=ruleXBlockExpression
	{ $current=$iv_ruleXBlockExpression.current; }
	EOF;

// Rule XBlockExpression
ruleXBlockExpression returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXBlockExpression_XBlockExpressionAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXBlockExpression_LeftCurlyBracketKeyword_1ElementType());
		}
		otherlv_1='{'
		{
			doneLeaf(otherlv_1);
		}
		(
			(
				(
					{
						markComposite(elementTypeProvider.getXBlockExpression_ExpressionsXExpressionOrVarDeclarationParserRuleCall_2_0_0ElementType());
					}
					lv_expressions_2_0=ruleXExpressionOrVarDeclaration
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			(
				{
					markLeaf(elementTypeProvider.getXBlockExpression_SemicolonKeyword_2_1ElementType());
				}
				otherlv_3=';'
				{
					doneLeaf(otherlv_3);
				}
			)?
		)*
		{
			markLeaf(elementTypeProvider.getXBlockExpression_RightCurlyBracketKeyword_3ElementType());
		}
		otherlv_4='}'
		{
			doneLeaf(otherlv_4);
		}
	)
;

//Entry rule entryRuleXExpressionOrVarDeclaration
entryRuleXExpressionOrVarDeclaration returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXExpressionOrVarDeclarationElementType()); }
	iv_ruleXExpressionOrVarDeclaration=ruleXExpressionOrVarDeclaration
	{ $current=$iv_ruleXExpressionOrVarDeclaration.current; }
	EOF;

// Rule XExpressionOrVarDeclaration
ruleXExpressionOrVarDeclaration returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getXExpressionOrVarDeclaration_XVariableDeclarationParserRuleCall_0ElementType());
		}
		this_XVariableDeclaration_0=ruleXVariableDeclaration
		{
			$current = $this_XVariableDeclaration_0.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getXExpressionOrVarDeclaration_XExpressionParserRuleCall_1ElementType());
		}
		this_XExpression_1=ruleXExpression
		{
			$current = $this_XExpression_1.current;
			doneComposite();
		}
	)
;

//Entry rule entryRuleXVariableDeclaration
entryRuleXVariableDeclaration returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXVariableDeclarationElementType()); }
	iv_ruleXVariableDeclaration=ruleXVariableDeclaration
	{ $current=$iv_ruleXVariableDeclaration.current; }
	EOF;

// Rule XVariableDeclaration
ruleXVariableDeclaration returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXVariableDeclaration_XVariableDeclarationAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		(
			(
				(
					{
						markLeaf(elementTypeProvider.getXVariableDeclaration_WriteableVarKeyword_1_0_0ElementType());
					}
					lv_writeable_1_0='var'
					{
						doneLeaf(lv_writeable_1_0);
					}
					{
						if (!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			    |
			{
				markLeaf(elementTypeProvider.getXVariableDeclaration_ValKeyword_1_1ElementType());
			}
			otherlv_2='val'
			{
				doneLeaf(otherlv_2);
			}
		)
		(
			(
				((
					(
						(
							ruleJvmTypeReference
						)
					)
					(
						(
							ruleValidID
						)
					)
				)
				)=>
				(
					(
						(
							{
								markComposite(elementTypeProvider.getXVariableDeclaration_TypeJvmTypeReferenceParserRuleCall_2_0_0_0_0ElementType());
							}
							lv_type_3_0=ruleJvmTypeReference
							{
								doneComposite();
								if(!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
					(
						(
							{
								markComposite(elementTypeProvider.getXVariableDeclaration_NameValidIDParserRuleCall_2_0_0_1_0ElementType());
							}
							lv_name_4_0=ruleValidID
							{
								doneComposite();
								if(!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
				)
			)
			    |
			(
				(
					{
						markComposite(elementTypeProvider.getXVariableDeclaration_NameValidIDParserRuleCall_2_1_0ElementType());
					}
					lv_name_5_0=ruleValidID
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)
		(
			{
				markLeaf(elementTypeProvider.getXVariableDeclaration_EqualsSignKeyword_3_0ElementType());
			}
			otherlv_6='='
			{
				doneLeaf(otherlv_6);
			}
			(
				(
					{
						markComposite(elementTypeProvider.getXVariableDeclaration_RightXExpressionParserRuleCall_3_1_0ElementType());
					}
					lv_right_7_0=ruleXExpression
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)?
	)
;

//Entry rule entryRuleJvmFormalParameter
entryRuleJvmFormalParameter returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getJvmFormalParameterElementType()); }
	iv_ruleJvmFormalParameter=ruleJvmFormalParameter
	{ $current=$iv_ruleJvmFormalParameter.current; }
	EOF;

// Rule JvmFormalParameter
ruleJvmFormalParameter returns [Boolean current=false]
:
	(
		(
			(
				{
					markComposite(elementTypeProvider.getJvmFormalParameter_ParameterTypeJvmTypeReferenceParserRuleCall_0_0ElementType());
				}
				lv_parameterType_0_0=ruleJvmTypeReference
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)?
		(
			(
				{
					markComposite(elementTypeProvider.getJvmFormalParameter_NameValidIDParserRuleCall_1_0ElementType());
				}
				lv_name_1_0=ruleValidID
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleFullJvmFormalParameter
entryRuleFullJvmFormalParameter returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getFullJvmFormalParameterElementType()); }
	iv_ruleFullJvmFormalParameter=ruleFullJvmFormalParameter
	{ $current=$iv_ruleFullJvmFormalParameter.current; }
	EOF;

// Rule FullJvmFormalParameter
ruleFullJvmFormalParameter returns [Boolean current=false]
:
	(
		(
			(
				{
					markComposite(elementTypeProvider.getFullJvmFormalParameter_ParameterTypeJvmTypeReferenceParserRuleCall_0_0ElementType());
				}
				lv_parameterType_0_0=ruleJvmTypeReference
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		(
			(
				{
					markComposite(elementTypeProvider.getFullJvmFormalParameter_NameValidIDParserRuleCall_1_0ElementType());
				}
				lv_name_1_0=ruleValidID
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleXFeatureCall
entryRuleXFeatureCall returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXFeatureCallElementType()); }
	iv_ruleXFeatureCall=ruleXFeatureCall
	{ $current=$iv_ruleXFeatureCall.current; }
	EOF;

// Rule XFeatureCall
ruleXFeatureCall returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXFeatureCall_XFeatureCallAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		(
			{
				markLeaf(elementTypeProvider.getXFeatureCall_LessThanSignKeyword_1_0ElementType());
			}
			otherlv_1='<'
			{
				doneLeaf(otherlv_1);
			}
			(
				(
					{
						markComposite(elementTypeProvider.getXFeatureCall_TypeArgumentsJvmArgumentTypeReferenceParserRuleCall_1_1_0ElementType());
					}
					lv_typeArguments_2_0=ruleJvmArgumentTypeReference
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			(
				{
					markLeaf(elementTypeProvider.getXFeatureCall_CommaKeyword_1_2_0ElementType());
				}
				otherlv_3=','
				{
					doneLeaf(otherlv_3);
				}
				(
					(
						{
							markComposite(elementTypeProvider.getXFeatureCall_TypeArgumentsJvmArgumentTypeReferenceParserRuleCall_1_2_1_0ElementType());
						}
						lv_typeArguments_4_0=ruleJvmArgumentTypeReference
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)*
			{
				markLeaf(elementTypeProvider.getXFeatureCall_GreaterThanSignKeyword_1_3ElementType());
			}
			otherlv_5='>'
			{
				doneLeaf(otherlv_5);
			}
		)?
		(
			(
				{
					if (!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
				{
					markComposite(elementTypeProvider.getXFeatureCall_FeatureJvmIdentifiableElementCrossReference_2_0ElementType());
				}
				ruleIdOrSuper
				{
					doneComposite();
				}
			)
		)
		(
			(
				((
					'('
				)
				)=>
				(
					{
						markLeaf(elementTypeProvider.getXFeatureCall_ExplicitOperationCallLeftParenthesisKeyword_3_0_0ElementType());
					}
					lv_explicitOperationCall_7_0='('
					{
						doneLeaf(lv_explicitOperationCall_7_0);
					}
					{
						if (!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			(
				(
					((
						(
						)
						(
							(
								(
									ruleJvmFormalParameter
								)
							)
							(
								','
								(
									(
										ruleJvmFormalParameter
									)
								)
							)*
						)?
						(
							(
								'|'
							)
						)
					)
					)=>
					(
						{
							markComposite(elementTypeProvider.getXFeatureCall_FeatureCallArgumentsXShortClosureParserRuleCall_3_1_0_0ElementType());
						}
						lv_featureCallArguments_8_0=ruleXShortClosure
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
				    |
				(
					(
						(
							{
								markComposite(elementTypeProvider.getXFeatureCall_FeatureCallArgumentsXExpressionParserRuleCall_3_1_1_0_0ElementType());
							}
							lv_featureCallArguments_9_0=ruleXExpression
							{
								doneComposite();
								if(!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
					(
						{
							markLeaf(elementTypeProvider.getXFeatureCall_CommaKeyword_3_1_1_1_0ElementType());
						}
						otherlv_10=','
						{
							doneLeaf(otherlv_10);
						}
						(
							(
								{
									markComposite(elementTypeProvider.getXFeatureCall_FeatureCallArgumentsXExpressionParserRuleCall_3_1_1_1_1_0ElementType());
								}
								lv_featureCallArguments_11_0=ruleXExpression
								{
									doneComposite();
									if(!$current) {
										associateWithSemanticElement();
										$current = true;
									}
								}
							)
						)
					)*
				)
			)?
			{
				markLeaf(elementTypeProvider.getXFeatureCall_RightParenthesisKeyword_3_2ElementType());
			}
			otherlv_12=')'
			{
				doneLeaf(otherlv_12);
			}
		)?
		(
			((
				(
				)
				'['
			)
			)=>
			(
				{
					markComposite(elementTypeProvider.getXFeatureCall_FeatureCallArgumentsXClosureParserRuleCall_4_0ElementType());
				}
				lv_featureCallArguments_13_0=ruleXClosure
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)?
	)
;

//Entry rule entryRuleFeatureCallID
entryRuleFeatureCallID returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getFeatureCallIDElementType()); }
	iv_ruleFeatureCallID=ruleFeatureCallID
	{ $current=$iv_ruleFeatureCallID.current; }
	EOF;

// Rule FeatureCallID
ruleFeatureCallID returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getFeatureCallID_ValidIDParserRuleCall_0ElementType());
		}
		ruleValidID
		{
			doneComposite();
		}
		    |
		{
			markLeaf(elementTypeProvider.getFeatureCallID_ExtendsKeyword_1ElementType());
		}
		kw='extends'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getFeatureCallID_StaticKeyword_2ElementType());
		}
		kw='static'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getFeatureCallID_ImportKeyword_3ElementType());
		}
		kw='import'
		{
			doneLeaf(kw);
		}
		    |
		{
			markLeaf(elementTypeProvider.getFeatureCallID_ExtensionKeyword_4ElementType());
		}
		kw='extension'
		{
			doneLeaf(kw);
		}
	)
;

//Entry rule entryRuleIdOrSuper
entryRuleIdOrSuper returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getIdOrSuperElementType()); }
	iv_ruleIdOrSuper=ruleIdOrSuper
	{ $current=$iv_ruleIdOrSuper.current; }
	EOF;

// Rule IdOrSuper
ruleIdOrSuper returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getIdOrSuper_FeatureCallIDParserRuleCall_0ElementType());
		}
		ruleFeatureCallID
		{
			doneComposite();
		}
		    |
		{
			markLeaf(elementTypeProvider.getIdOrSuper_SuperKeyword_1ElementType());
		}
		kw='super'
		{
			doneLeaf(kw);
		}
	)
;

//Entry rule entryRuleXConstructorCall
entryRuleXConstructorCall returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXConstructorCallElementType()); }
	iv_ruleXConstructorCall=ruleXConstructorCall
	{ $current=$iv_ruleXConstructorCall.current; }
	EOF;

// Rule XConstructorCall
ruleXConstructorCall returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXConstructorCall_XConstructorCallAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXConstructorCall_NewKeyword_1ElementType());
		}
		otherlv_1='new'
		{
			doneLeaf(otherlv_1);
		}
		(
			(
				{
					if (!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
				{
					markComposite(elementTypeProvider.getXConstructorCall_ConstructorJvmConstructorCrossReference_2_0ElementType());
				}
				ruleQualifiedName
				{
					doneComposite();
				}
			)
		)
		(
			(
				('<')=>
				{
					markLeaf(elementTypeProvider.getXConstructorCall_LessThanSignKeyword_3_0ElementType());
				}
				otherlv_3='<'
				{
					doneLeaf(otherlv_3);
				}
			)
			(
				(
					{
						markComposite(elementTypeProvider.getXConstructorCall_TypeArgumentsJvmArgumentTypeReferenceParserRuleCall_3_1_0ElementType());
					}
					lv_typeArguments_4_0=ruleJvmArgumentTypeReference
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			(
				{
					markLeaf(elementTypeProvider.getXConstructorCall_CommaKeyword_3_2_0ElementType());
				}
				otherlv_5=','
				{
					doneLeaf(otherlv_5);
				}
				(
					(
						{
							markComposite(elementTypeProvider.getXConstructorCall_TypeArgumentsJvmArgumentTypeReferenceParserRuleCall_3_2_1_0ElementType());
						}
						lv_typeArguments_6_0=ruleJvmArgumentTypeReference
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)*
			{
				markLeaf(elementTypeProvider.getXConstructorCall_GreaterThanSignKeyword_3_3ElementType());
			}
			otherlv_7='>'
			{
				doneLeaf(otherlv_7);
			}
		)?
		(
			(
				((
					'('
				)
				)=>
				(
					{
						markLeaf(elementTypeProvider.getXConstructorCall_ExplicitConstructorCallLeftParenthesisKeyword_4_0_0ElementType());
					}
					lv_explicitConstructorCall_8_0='('
					{
						doneLeaf(lv_explicitConstructorCall_8_0);
					}
					{
						if (!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			(
				(
					((
						(
						)
						(
							(
								(
									ruleJvmFormalParameter
								)
							)
							(
								','
								(
									(
										ruleJvmFormalParameter
									)
								)
							)*
						)?
						(
							(
								'|'
							)
						)
					)
					)=>
					(
						{
							markComposite(elementTypeProvider.getXConstructorCall_ArgumentsXShortClosureParserRuleCall_4_1_0_0ElementType());
						}
						lv_arguments_9_0=ruleXShortClosure
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
				    |
				(
					(
						(
							{
								markComposite(elementTypeProvider.getXConstructorCall_ArgumentsXExpressionParserRuleCall_4_1_1_0_0ElementType());
							}
							lv_arguments_10_0=ruleXExpression
							{
								doneComposite();
								if(!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
					(
						{
							markLeaf(elementTypeProvider.getXConstructorCall_CommaKeyword_4_1_1_1_0ElementType());
						}
						otherlv_11=','
						{
							doneLeaf(otherlv_11);
						}
						(
							(
								{
									markComposite(elementTypeProvider.getXConstructorCall_ArgumentsXExpressionParserRuleCall_4_1_1_1_1_0ElementType());
								}
								lv_arguments_12_0=ruleXExpression
								{
									doneComposite();
									if(!$current) {
										associateWithSemanticElement();
										$current = true;
									}
								}
							)
						)
					)*
				)
			)?
			{
				markLeaf(elementTypeProvider.getXConstructorCall_RightParenthesisKeyword_4_2ElementType());
			}
			otherlv_13=')'
			{
				doneLeaf(otherlv_13);
			}
		)?
		(
			((
				(
				)
				'['
			)
			)=>
			(
				{
					markComposite(elementTypeProvider.getXConstructorCall_ArgumentsXClosureParserRuleCall_5_0ElementType());
				}
				lv_arguments_14_0=ruleXClosure
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)?
	)
;

//Entry rule entryRuleXBooleanLiteral
entryRuleXBooleanLiteral returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXBooleanLiteralElementType()); }
	iv_ruleXBooleanLiteral=ruleXBooleanLiteral
	{ $current=$iv_ruleXBooleanLiteral.current; }
	EOF;

// Rule XBooleanLiteral
ruleXBooleanLiteral returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXBooleanLiteral_XBooleanLiteralAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		(
			{
				markLeaf(elementTypeProvider.getXBooleanLiteral_FalseKeyword_1_0ElementType());
			}
			otherlv_1='false'
			{
				doneLeaf(otherlv_1);
			}
			    |
			(
				(
					{
						markLeaf(elementTypeProvider.getXBooleanLiteral_IsTrueTrueKeyword_1_1_0ElementType());
					}
					lv_isTrue_2_0='true'
					{
						doneLeaf(lv_isTrue_2_0);
					}
					{
						if (!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)
	)
;

//Entry rule entryRuleXNullLiteral
entryRuleXNullLiteral returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXNullLiteralElementType()); }
	iv_ruleXNullLiteral=ruleXNullLiteral
	{ $current=$iv_ruleXNullLiteral.current; }
	EOF;

// Rule XNullLiteral
ruleXNullLiteral returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXNullLiteral_XNullLiteralAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXNullLiteral_NullKeyword_1ElementType());
		}
		otherlv_1='null'
		{
			doneLeaf(otherlv_1);
		}
	)
;

//Entry rule entryRuleXNumberLiteral
entryRuleXNumberLiteral returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXNumberLiteralElementType()); }
	iv_ruleXNumberLiteral=ruleXNumberLiteral
	{ $current=$iv_ruleXNumberLiteral.current; }
	EOF;

// Rule XNumberLiteral
ruleXNumberLiteral returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXNumberLiteral_XNumberLiteralAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		(
			(
				{
					markComposite(elementTypeProvider.getXNumberLiteral_ValueNumberParserRuleCall_1_0ElementType());
				}
				lv_value_1_0=ruleNumber
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleXStringLiteral
entryRuleXStringLiteral returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXStringLiteralElementType()); }
	iv_ruleXStringLiteral=ruleXStringLiteral
	{ $current=$iv_ruleXStringLiteral.current; }
	EOF;

// Rule XStringLiteral
ruleXStringLiteral returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXStringLiteral_XStringLiteralAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		(
			(
				{
					markLeaf(elementTypeProvider.getXStringLiteral_ValueSTRINGTerminalRuleCall_1_0ElementType());
				}
				lv_value_1_0=RULE_STRING
				{
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
				{
					doneLeaf(lv_value_1_0);
				}
			)
		)
	)
;

//Entry rule entryRuleXTypeLiteral
entryRuleXTypeLiteral returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXTypeLiteralElementType()); }
	iv_ruleXTypeLiteral=ruleXTypeLiteral
	{ $current=$iv_ruleXTypeLiteral.current; }
	EOF;

// Rule XTypeLiteral
ruleXTypeLiteral returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXTypeLiteral_XTypeLiteralAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXTypeLiteral_TypeofKeyword_1ElementType());
		}
		otherlv_1='typeof'
		{
			doneLeaf(otherlv_1);
		}
		{
			markLeaf(elementTypeProvider.getXTypeLiteral_LeftParenthesisKeyword_2ElementType());
		}
		otherlv_2='('
		{
			doneLeaf(otherlv_2);
		}
		(
			(
				{
					if (!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
				{
					markComposite(elementTypeProvider.getXTypeLiteral_TypeJvmTypeCrossReference_3_0ElementType());
				}
				ruleQualifiedName
				{
					doneComposite();
				}
			)
		)
		(
			(
				{
					markComposite(elementTypeProvider.getXTypeLiteral_ArrayDimensionsArrayBracketsParserRuleCall_4_0ElementType());
				}
				lv_arrayDimensions_4_0=ruleArrayBrackets
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)*
		{
			markLeaf(elementTypeProvider.getXTypeLiteral_RightParenthesisKeyword_5ElementType());
		}
		otherlv_5=')'
		{
			doneLeaf(otherlv_5);
		}
	)
;

//Entry rule entryRuleXThrowExpression
entryRuleXThrowExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXThrowExpressionElementType()); }
	iv_ruleXThrowExpression=ruleXThrowExpression
	{ $current=$iv_ruleXThrowExpression.current; }
	EOF;

// Rule XThrowExpression
ruleXThrowExpression returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXThrowExpression_XThrowExpressionAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXThrowExpression_ThrowKeyword_1ElementType());
		}
		otherlv_1='throw'
		{
			doneLeaf(otherlv_1);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXThrowExpression_ExpressionXExpressionParserRuleCall_2_0ElementType());
				}
				lv_expression_2_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleXReturnExpression
entryRuleXReturnExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXReturnExpressionElementType()); }
	iv_ruleXReturnExpression=ruleXReturnExpression
	{ $current=$iv_ruleXReturnExpression.current; }
	EOF;

// Rule XReturnExpression
ruleXReturnExpression returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXReturnExpression_XReturnExpressionAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXReturnExpression_ReturnKeyword_1ElementType());
		}
		otherlv_1='return'
		{
			doneLeaf(otherlv_1);
		}
		(
			('extends' | 'static' | 'import' | 'extension' | '!' | '-' | '+' | 'new' | '{' | 'switch' | 'synchronized' | '<' | 'super' | '#' | '[' | 'false' | 'true' | 'null' | 'typeof' | 'if' | 'for' | 'while' | 'do' | 'throw' | 'return' | 'try' | '(' | RULE_ID | RULE_HEX | RULE_INT | RULE_DECIMAL | RULE_STRING)=>
			(
				{
					markComposite(elementTypeProvider.getXReturnExpression_ExpressionXExpressionParserRuleCall_2_0ElementType());
				}
				lv_expression_2_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)?
	)
;

//Entry rule entryRuleXTryCatchFinallyExpression
entryRuleXTryCatchFinallyExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXTryCatchFinallyExpressionElementType()); }
	iv_ruleXTryCatchFinallyExpression=ruleXTryCatchFinallyExpression
	{ $current=$iv_ruleXTryCatchFinallyExpression.current; }
	EOF;

// Rule XTryCatchFinallyExpression
ruleXTryCatchFinallyExpression returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getXTryCatchFinallyExpression_XTryCatchFinallyExpressionAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getXTryCatchFinallyExpression_TryKeyword_1ElementType());
		}
		otherlv_1='try'
		{
			doneLeaf(otherlv_1);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXTryCatchFinallyExpression_ExpressionXExpressionParserRuleCall_2_0ElementType());
				}
				lv_expression_2_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		(
			(
				(
					('catch')=>
					(
						{
							markComposite(elementTypeProvider.getXTryCatchFinallyExpression_CatchClausesXCatchClauseParserRuleCall_3_0_0_0ElementType());
						}
						lv_catchClauses_3_0=ruleXCatchClause
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)+
				(
					(
						('finally')=>
						{
							markLeaf(elementTypeProvider.getXTryCatchFinallyExpression_FinallyKeyword_3_0_1_0ElementType());
						}
						otherlv_4='finally'
						{
							doneLeaf(otherlv_4);
						}
					)
					(
						(
							{
								markComposite(elementTypeProvider.getXTryCatchFinallyExpression_FinallyExpressionXExpressionParserRuleCall_3_0_1_1_0ElementType());
							}
							lv_finallyExpression_5_0=ruleXExpression
							{
								doneComposite();
								if(!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
				)?
			)
			    |
			(
				{
					markLeaf(elementTypeProvider.getXTryCatchFinallyExpression_FinallyKeyword_3_1_0ElementType());
				}
				otherlv_6='finally'
				{
					doneLeaf(otherlv_6);
				}
				(
					(
						{
							markComposite(elementTypeProvider.getXTryCatchFinallyExpression_FinallyExpressionXExpressionParserRuleCall_3_1_1_0ElementType());
						}
						lv_finallyExpression_7_0=ruleXExpression
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)
		)
	)
;

//Entry rule entryRuleXSynchronizedExpression
entryRuleXSynchronizedExpression returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXSynchronizedExpressionElementType()); }
	iv_ruleXSynchronizedExpression=ruleXSynchronizedExpression
	{ $current=$iv_ruleXSynchronizedExpression.current; }
	EOF;

// Rule XSynchronizedExpression
ruleXSynchronizedExpression returns [Boolean current=false]
:
	(
		(
			((
				(
				)
				'synchronized'
				'('
			)
			)=>
			(
				(
					{
						precedeComposite(elementTypeProvider.getXSynchronizedExpression_XSynchronizedExpressionAction_0_0_0ElementType());
						doneComposite();
						associateWithSemanticElement();
					}
				)
				{
					markLeaf(elementTypeProvider.getXSynchronizedExpression_SynchronizedKeyword_0_0_1ElementType());
				}
				otherlv_1='synchronized'
				{
					doneLeaf(otherlv_1);
				}
				{
					markLeaf(elementTypeProvider.getXSynchronizedExpression_LeftParenthesisKeyword_0_0_2ElementType());
				}
				otherlv_2='('
				{
					doneLeaf(otherlv_2);
				}
			)
		)
		(
			(
				{
					markComposite(elementTypeProvider.getXSynchronizedExpression_ParamXExpressionParserRuleCall_1_0ElementType());
				}
				lv_param_3_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		{
			markLeaf(elementTypeProvider.getXSynchronizedExpression_RightParenthesisKeyword_2ElementType());
		}
		otherlv_4=')'
		{
			doneLeaf(otherlv_4);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXSynchronizedExpression_ExpressionXExpressionParserRuleCall_3_0ElementType());
				}
				lv_expression_5_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleXCatchClause
entryRuleXCatchClause returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXCatchClauseElementType()); }
	iv_ruleXCatchClause=ruleXCatchClause
	{ $current=$iv_ruleXCatchClause.current; }
	EOF;

// Rule XCatchClause
ruleXCatchClause returns [Boolean current=false]
:
	(
		(
			('catch')=>
			{
				markLeaf(elementTypeProvider.getXCatchClause_CatchKeyword_0ElementType());
			}
			otherlv_0='catch'
			{
				doneLeaf(otherlv_0);
			}
		)
		{
			markLeaf(elementTypeProvider.getXCatchClause_LeftParenthesisKeyword_1ElementType());
		}
		otherlv_1='('
		{
			doneLeaf(otherlv_1);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXCatchClause_DeclaredParamFullJvmFormalParameterParserRuleCall_2_0ElementType());
				}
				lv_declaredParam_2_0=ruleFullJvmFormalParameter
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
		{
			markLeaf(elementTypeProvider.getXCatchClause_RightParenthesisKeyword_3ElementType());
		}
		otherlv_3=')'
		{
			doneLeaf(otherlv_3);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXCatchClause_ExpressionXExpressionParserRuleCall_4_0ElementType());
				}
				lv_expression_4_0=ruleXExpression
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleQualifiedName
entryRuleQualifiedName returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getQualifiedNameElementType()); }
	iv_ruleQualifiedName=ruleQualifiedName
	{ $current=$iv_ruleQualifiedName.current; }
	EOF;

// Rule QualifiedName
ruleQualifiedName returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getQualifiedName_ValidIDParserRuleCall_0ElementType());
		}
		ruleValidID
		{
			doneComposite();
		}
		(
			(
				('.')=>
				{
					markLeaf(elementTypeProvider.getQualifiedName_FullStopKeyword_1_0ElementType());
				}
				kw='.'
				{
					doneLeaf(kw);
				}
			)
			{
				markComposite(elementTypeProvider.getQualifiedName_ValidIDParserRuleCall_1_1ElementType());
			}
			ruleValidID
			{
				doneComposite();
			}
		)*
	)
;

//Entry rule entryRuleNumber
entryRuleNumber returns [Boolean current=false]@init {
	HiddenTokens myHiddenTokenState = ((XtextTokenStream)input).setHiddenTokens();
}:
	{ markComposite(elementTypeProvider.getNumberElementType()); }
	iv_ruleNumber=ruleNumber
	{ $current=$iv_ruleNumber.current; }
	EOF;
finally {
	myHiddenTokenState.restore();
}

// Rule Number
ruleNumber returns [Boolean current=false]
@init {
	HiddenTokens myHiddenTokenState = ((XtextTokenStream)input).setHiddenTokens();
}:
	(
		{
			markLeaf(elementTypeProvider.getNumber_HEXTerminalRuleCall_0ElementType());
		}
		this_HEX_0=RULE_HEX
		{
			doneLeaf(this_HEX_0);
		}
		    |
		(
			(
				{
					markLeaf(elementTypeProvider.getNumber_INTTerminalRuleCall_1_0_0ElementType());
				}
				this_INT_1=RULE_INT
				{
					doneLeaf(this_INT_1);
				}
				    |
				{
					markLeaf(elementTypeProvider.getNumber_DECIMALTerminalRuleCall_1_0_1ElementType());
				}
				this_DECIMAL_2=RULE_DECIMAL
				{
					doneLeaf(this_DECIMAL_2);
				}
			)
			(
				{
					markLeaf(elementTypeProvider.getNumber_FullStopKeyword_1_1_0ElementType());
				}
				kw='.'
				{
					doneLeaf(kw);
				}
				(
					{
						markLeaf(elementTypeProvider.getNumber_INTTerminalRuleCall_1_1_1_0ElementType());
					}
					this_INT_4=RULE_INT
					{
						doneLeaf(this_INT_4);
					}
					    |
					{
						markLeaf(elementTypeProvider.getNumber_DECIMALTerminalRuleCall_1_1_1_1ElementType());
					}
					this_DECIMAL_5=RULE_DECIMAL
					{
						doneLeaf(this_DECIMAL_5);
					}
				)
			)?
		)
	)
;
finally {
	myHiddenTokenState.restore();
}

//Entry rule entryRuleJvmTypeReference
entryRuleJvmTypeReference returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getJvmTypeReferenceElementType()); }
	iv_ruleJvmTypeReference=ruleJvmTypeReference
	{ $current=$iv_ruleJvmTypeReference.current; }
	EOF;

// Rule JvmTypeReference
ruleJvmTypeReference returns [Boolean current=false]
:
	(
		(
			{
				markComposite(elementTypeProvider.getJvmTypeReference_JvmParameterizedTypeReferenceParserRuleCall_0_0ElementType());
			}
			this_JvmParameterizedTypeReference_0=ruleJvmParameterizedTypeReference
			{
				$current = $this_JvmParameterizedTypeReference_0.current;
				doneComposite();
			}
			(
				((
					(
					)
					ruleArrayBrackets
				)
				)=>
				(
					(
						{
							precedeComposite(elementTypeProvider.getJvmTypeReference_JvmGenericArrayTypeReferenceComponentTypeAction_0_1_0_0ElementType());
							doneComposite();
							associateWithSemanticElement();
						}
					)
					{
						markComposite(elementTypeProvider.getJvmTypeReference_ArrayBracketsParserRuleCall_0_1_0_1ElementType());
					}
					ruleArrayBrackets
					{
						doneComposite();
					}
				)
			)*
		)
		    |
		{
			markComposite(elementTypeProvider.getJvmTypeReference_XFunctionTypeRefParserRuleCall_1ElementType());
		}
		this_XFunctionTypeRef_3=ruleXFunctionTypeRef
		{
			$current = $this_XFunctionTypeRef_3.current;
			doneComposite();
		}
	)
;

//Entry rule entryRuleArrayBrackets
entryRuleArrayBrackets returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getArrayBracketsElementType()); }
	iv_ruleArrayBrackets=ruleArrayBrackets
	{ $current=$iv_ruleArrayBrackets.current; }
	EOF;

// Rule ArrayBrackets
ruleArrayBrackets returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getArrayBrackets_LeftSquareBracketKeyword_0ElementType());
		}
		kw='['
		{
			doneLeaf(kw);
		}
		{
			markLeaf(elementTypeProvider.getArrayBrackets_RightSquareBracketKeyword_1ElementType());
		}
		kw=']'
		{
			doneLeaf(kw);
		}
	)
;

//Entry rule entryRuleXFunctionTypeRef
entryRuleXFunctionTypeRef returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXFunctionTypeRefElementType()); }
	iv_ruleXFunctionTypeRef=ruleXFunctionTypeRef
	{ $current=$iv_ruleXFunctionTypeRef.current; }
	EOF;

// Rule XFunctionTypeRef
ruleXFunctionTypeRef returns [Boolean current=false]
:
	(
		(
			{
				markLeaf(elementTypeProvider.getXFunctionTypeRef_LeftParenthesisKeyword_0_0ElementType());
			}
			otherlv_0='('
			{
				doneLeaf(otherlv_0);
			}
			(
				(
					(
						{
							markComposite(elementTypeProvider.getXFunctionTypeRef_ParamTypesJvmTypeReferenceParserRuleCall_0_1_0_0ElementType());
						}
						lv_paramTypes_1_0=ruleJvmTypeReference
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
				(
					{
						markLeaf(elementTypeProvider.getXFunctionTypeRef_CommaKeyword_0_1_1_0ElementType());
					}
					otherlv_2=','
					{
						doneLeaf(otherlv_2);
					}
					(
						(
							{
								markComposite(elementTypeProvider.getXFunctionTypeRef_ParamTypesJvmTypeReferenceParserRuleCall_0_1_1_1_0ElementType());
							}
							lv_paramTypes_3_0=ruleJvmTypeReference
							{
								doneComposite();
								if(!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
				)*
			)?
			{
				markLeaf(elementTypeProvider.getXFunctionTypeRef_RightParenthesisKeyword_0_2ElementType());
			}
			otherlv_4=')'
			{
				doneLeaf(otherlv_4);
			}
		)?
		{
			markLeaf(elementTypeProvider.getXFunctionTypeRef_EqualsSignGreaterThanSignKeyword_1ElementType());
		}
		otherlv_5='=>'
		{
			doneLeaf(otherlv_5);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getXFunctionTypeRef_ReturnTypeJvmTypeReferenceParserRuleCall_2_0ElementType());
				}
				lv_returnType_6_0=ruleJvmTypeReference
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleJvmParameterizedTypeReference
entryRuleJvmParameterizedTypeReference returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getJvmParameterizedTypeReferenceElementType()); }
	iv_ruleJvmParameterizedTypeReference=ruleJvmParameterizedTypeReference
	{ $current=$iv_ruleJvmParameterizedTypeReference.current; }
	EOF;

// Rule JvmParameterizedTypeReference
ruleJvmParameterizedTypeReference returns [Boolean current=false]
:
	(
		(
			(
				{
					if (!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
				{
					markComposite(elementTypeProvider.getJvmParameterizedTypeReference_TypeJvmTypeCrossReference_0_0ElementType());
				}
				ruleQualifiedName
				{
					doneComposite();
				}
			)
		)
		(
			(
				('<')=>
				{
					markLeaf(elementTypeProvider.getJvmParameterizedTypeReference_LessThanSignKeyword_1_0ElementType());
				}
				otherlv_1='<'
				{
					doneLeaf(otherlv_1);
				}
			)
			(
				(
					{
						markComposite(elementTypeProvider.getJvmParameterizedTypeReference_ArgumentsJvmArgumentTypeReferenceParserRuleCall_1_1_0ElementType());
					}
					lv_arguments_2_0=ruleJvmArgumentTypeReference
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
			(
				{
					markLeaf(elementTypeProvider.getJvmParameterizedTypeReference_CommaKeyword_1_2_0ElementType());
				}
				otherlv_3=','
				{
					doneLeaf(otherlv_3);
				}
				(
					(
						{
							markComposite(elementTypeProvider.getJvmParameterizedTypeReference_ArgumentsJvmArgumentTypeReferenceParserRuleCall_1_2_1_0ElementType());
						}
						lv_arguments_4_0=ruleJvmArgumentTypeReference
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
			)*
			{
				markLeaf(elementTypeProvider.getJvmParameterizedTypeReference_GreaterThanSignKeyword_1_3ElementType());
			}
			otherlv_5='>'
			{
				doneLeaf(otherlv_5);
			}
			(
				(
					((
						(
						)
						'.'
					)
					)=>
					(
						(
							{
								precedeComposite(elementTypeProvider.getJvmParameterizedTypeReference_JvmInnerTypeReferenceOuterAction_1_4_0_0_0ElementType());
								doneComposite();
								associateWithSemanticElement();
							}
						)
						{
							markLeaf(elementTypeProvider.getJvmParameterizedTypeReference_FullStopKeyword_1_4_0_0_1ElementType());
						}
						otherlv_7='.'
						{
							doneLeaf(otherlv_7);
						}
					)
				)
				(
					(
						{
							if (!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
						{
							markComposite(elementTypeProvider.getJvmParameterizedTypeReference_TypeJvmTypeCrossReference_1_4_1_0ElementType());
						}
						ruleValidID
						{
							doneComposite();
						}
					)
				)
				(
					(
						('<')=>
						{
							markLeaf(elementTypeProvider.getJvmParameterizedTypeReference_LessThanSignKeyword_1_4_2_0ElementType());
						}
						otherlv_9='<'
						{
							doneLeaf(otherlv_9);
						}
					)
					(
						(
							{
								markComposite(elementTypeProvider.getJvmParameterizedTypeReference_ArgumentsJvmArgumentTypeReferenceParserRuleCall_1_4_2_1_0ElementType());
							}
							lv_arguments_10_0=ruleJvmArgumentTypeReference
							{
								doneComposite();
								if(!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
					(
						{
							markLeaf(elementTypeProvider.getJvmParameterizedTypeReference_CommaKeyword_1_4_2_2_0ElementType());
						}
						otherlv_11=','
						{
							doneLeaf(otherlv_11);
						}
						(
							(
								{
									markComposite(elementTypeProvider.getJvmParameterizedTypeReference_ArgumentsJvmArgumentTypeReferenceParserRuleCall_1_4_2_2_1_0ElementType());
								}
								lv_arguments_12_0=ruleJvmArgumentTypeReference
								{
									doneComposite();
									if(!$current) {
										associateWithSemanticElement();
										$current = true;
									}
								}
							)
						)
					)*
					{
						markLeaf(elementTypeProvider.getJvmParameterizedTypeReference_GreaterThanSignKeyword_1_4_2_3ElementType());
					}
					otherlv_13='>'
					{
						doneLeaf(otherlv_13);
					}
				)?
			)*
		)?
	)
;

//Entry rule entryRuleJvmArgumentTypeReference
entryRuleJvmArgumentTypeReference returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getJvmArgumentTypeReferenceElementType()); }
	iv_ruleJvmArgumentTypeReference=ruleJvmArgumentTypeReference
	{ $current=$iv_ruleJvmArgumentTypeReference.current; }
	EOF;

// Rule JvmArgumentTypeReference
ruleJvmArgumentTypeReference returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getJvmArgumentTypeReference_JvmTypeReferenceParserRuleCall_0ElementType());
		}
		this_JvmTypeReference_0=ruleJvmTypeReference
		{
			$current = $this_JvmTypeReference_0.current;
			doneComposite();
		}
		    |
		{
			markComposite(elementTypeProvider.getJvmArgumentTypeReference_JvmWildcardTypeReferenceParserRuleCall_1ElementType());
		}
		this_JvmWildcardTypeReference_1=ruleJvmWildcardTypeReference
		{
			$current = $this_JvmWildcardTypeReference_1.current;
			doneComposite();
		}
	)
;

//Entry rule entryRuleJvmWildcardTypeReference
entryRuleJvmWildcardTypeReference returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getJvmWildcardTypeReferenceElementType()); }
	iv_ruleJvmWildcardTypeReference=ruleJvmWildcardTypeReference
	{ $current=$iv_ruleJvmWildcardTypeReference.current; }
	EOF;

// Rule JvmWildcardTypeReference
ruleJvmWildcardTypeReference returns [Boolean current=false]
:
	(
		(
			{
				precedeComposite(elementTypeProvider.getJvmWildcardTypeReference_JvmWildcardTypeReferenceAction_0ElementType());
				doneComposite();
				associateWithSemanticElement();
			}
		)
		{
			markLeaf(elementTypeProvider.getJvmWildcardTypeReference_QuestionMarkKeyword_1ElementType());
		}
		otherlv_1='?'
		{
			doneLeaf(otherlv_1);
		}
		(
			(
				(
					(
						{
							markComposite(elementTypeProvider.getJvmWildcardTypeReference_ConstraintsJvmUpperBoundParserRuleCall_2_0_0_0ElementType());
						}
						lv_constraints_2_0=ruleJvmUpperBound
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
				(
					(
						{
							markComposite(elementTypeProvider.getJvmWildcardTypeReference_ConstraintsJvmUpperBoundAndedParserRuleCall_2_0_1_0ElementType());
						}
						lv_constraints_3_0=ruleJvmUpperBoundAnded
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)*
			)
			    |
			(
				(
					(
						{
							markComposite(elementTypeProvider.getJvmWildcardTypeReference_ConstraintsJvmLowerBoundParserRuleCall_2_1_0_0ElementType());
						}
						lv_constraints_4_0=ruleJvmLowerBound
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
				(
					(
						{
							markComposite(elementTypeProvider.getJvmWildcardTypeReference_ConstraintsJvmLowerBoundAndedParserRuleCall_2_1_1_0ElementType());
						}
						lv_constraints_5_0=ruleJvmLowerBoundAnded
						{
							doneComposite();
							if(!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)*
			)
		)?
	)
;

//Entry rule entryRuleJvmUpperBound
entryRuleJvmUpperBound returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getJvmUpperBoundElementType()); }
	iv_ruleJvmUpperBound=ruleJvmUpperBound
	{ $current=$iv_ruleJvmUpperBound.current; }
	EOF;

// Rule JvmUpperBound
ruleJvmUpperBound returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getJvmUpperBound_ExtendsKeyword_0ElementType());
		}
		otherlv_0='extends'
		{
			doneLeaf(otherlv_0);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getJvmUpperBound_TypeReferenceJvmTypeReferenceParserRuleCall_1_0ElementType());
				}
				lv_typeReference_1_0=ruleJvmTypeReference
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleJvmUpperBoundAnded
entryRuleJvmUpperBoundAnded returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getJvmUpperBoundAndedElementType()); }
	iv_ruleJvmUpperBoundAnded=ruleJvmUpperBoundAnded
	{ $current=$iv_ruleJvmUpperBoundAnded.current; }
	EOF;

// Rule JvmUpperBoundAnded
ruleJvmUpperBoundAnded returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getJvmUpperBoundAnded_AmpersandKeyword_0ElementType());
		}
		otherlv_0='&'
		{
			doneLeaf(otherlv_0);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getJvmUpperBoundAnded_TypeReferenceJvmTypeReferenceParserRuleCall_1_0ElementType());
				}
				lv_typeReference_1_0=ruleJvmTypeReference
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleJvmLowerBound
entryRuleJvmLowerBound returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getJvmLowerBoundElementType()); }
	iv_ruleJvmLowerBound=ruleJvmLowerBound
	{ $current=$iv_ruleJvmLowerBound.current; }
	EOF;

// Rule JvmLowerBound
ruleJvmLowerBound returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getJvmLowerBound_SuperKeyword_0ElementType());
		}
		otherlv_0='super'
		{
			doneLeaf(otherlv_0);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getJvmLowerBound_TypeReferenceJvmTypeReferenceParserRuleCall_1_0ElementType());
				}
				lv_typeReference_1_0=ruleJvmTypeReference
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleJvmLowerBoundAnded
entryRuleJvmLowerBoundAnded returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getJvmLowerBoundAndedElementType()); }
	iv_ruleJvmLowerBoundAnded=ruleJvmLowerBoundAnded
	{ $current=$iv_ruleJvmLowerBoundAnded.current; }
	EOF;

// Rule JvmLowerBoundAnded
ruleJvmLowerBoundAnded returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getJvmLowerBoundAnded_AmpersandKeyword_0ElementType());
		}
		otherlv_0='&'
		{
			doneLeaf(otherlv_0);
		}
		(
			(
				{
					markComposite(elementTypeProvider.getJvmLowerBoundAnded_TypeReferenceJvmTypeReferenceParserRuleCall_1_0ElementType());
				}
				lv_typeReference_1_0=ruleJvmTypeReference
				{
					doneComposite();
					if(!$current) {
						associateWithSemanticElement();
						$current = true;
					}
				}
			)
		)
	)
;

//Entry rule entryRuleQualifiedNameWithWildcard
entryRuleQualifiedNameWithWildcard returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getQualifiedNameWithWildcardElementType()); }
	iv_ruleQualifiedNameWithWildcard=ruleQualifiedNameWithWildcard
	{ $current=$iv_ruleQualifiedNameWithWildcard.current; }
	EOF;

// Rule QualifiedNameWithWildcard
ruleQualifiedNameWithWildcard returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getQualifiedNameWithWildcard_QualifiedNameParserRuleCall_0ElementType());
		}
		ruleQualifiedName
		{
			doneComposite();
		}
		{
			markLeaf(elementTypeProvider.getQualifiedNameWithWildcard_FullStopKeyword_1ElementType());
		}
		kw='.'
		{
			doneLeaf(kw);
		}
		{
			markLeaf(elementTypeProvider.getQualifiedNameWithWildcard_AsteriskKeyword_2ElementType());
		}
		kw='*'
		{
			doneLeaf(kw);
		}
	)
;

//Entry rule entryRuleValidID
entryRuleValidID returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getValidIDElementType()); }
	iv_ruleValidID=ruleValidID
	{ $current=$iv_ruleValidID.current; }
	EOF;

// Rule ValidID
ruleValidID returns [Boolean current=false]
:
	{
		markLeaf(elementTypeProvider.getValidID_IDTerminalRuleCallElementType());
	}
	this_ID_0=RULE_ID
	{
		doneLeaf(this_ID_0);
	}
;

//Entry rule entryRuleXImportSection
entryRuleXImportSection returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXImportSectionElementType()); }
	iv_ruleXImportSection=ruleXImportSection
	{ $current=$iv_ruleXImportSection.current; }
	EOF;

// Rule XImportSection
ruleXImportSection returns [Boolean current=false]
:
	(
		(
			{
				markComposite(elementTypeProvider.getXImportSection_ImportDeclarationsXImportDeclarationParserRuleCall_0ElementType());
			}
			lv_importDeclarations_0_0=ruleXImportDeclaration
			{
				doneComposite();
				if(!$current) {
					associateWithSemanticElement();
					$current = true;
				}
			}
		)
	)+
;

//Entry rule entryRuleXImportDeclaration
entryRuleXImportDeclaration returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getXImportDeclarationElementType()); }
	iv_ruleXImportDeclaration=ruleXImportDeclaration
	{ $current=$iv_ruleXImportDeclaration.current; }
	EOF;

// Rule XImportDeclaration
ruleXImportDeclaration returns [Boolean current=false]
:
	(
		{
			markLeaf(elementTypeProvider.getXImportDeclaration_ImportKeyword_0ElementType());
		}
		otherlv_0='import'
		{
			doneLeaf(otherlv_0);
		}
		(
			(
				(
					(
						{
							markLeaf(elementTypeProvider.getXImportDeclaration_StaticStaticKeyword_1_0_0_0ElementType());
						}
						lv_static_1_0='static'
						{
							doneLeaf(lv_static_1_0);
						}
						{
							if (!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)
				(
					(
						{
							markLeaf(elementTypeProvider.getXImportDeclaration_ExtensionExtensionKeyword_1_0_1_0ElementType());
						}
						lv_extension_2_0='extension'
						{
							doneLeaf(lv_extension_2_0);
						}
						{
							if (!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
					)
				)?
				(
					(
						{
							if (!$current) {
								associateWithSemanticElement();
								$current = true;
							}
						}
						{
							markComposite(elementTypeProvider.getXImportDeclaration_ImportedTypeJvmDeclaredTypeCrossReference_1_0_2_0ElementType());
						}
						ruleQualifiedNameInStaticImport
						{
							doneComposite();
						}
					)
				)
				(
					(
						(
							{
								markLeaf(elementTypeProvider.getXImportDeclaration_WildcardAsteriskKeyword_1_0_3_0_0ElementType());
							}
							lv_wildcard_4_0='*'
							{
								doneLeaf(lv_wildcard_4_0);
							}
							{
								if (!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
					    |
					(
						(
							{
								markComposite(elementTypeProvider.getXImportDeclaration_MemberNameValidIDParserRuleCall_1_0_3_1_0ElementType());
							}
							lv_memberName_5_0=ruleValidID
							{
								doneComposite();
								if(!$current) {
									associateWithSemanticElement();
									$current = true;
								}
							}
						)
					)
				)
			)
			    |
			(
				(
					{
						if (!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
					{
						markComposite(elementTypeProvider.getXImportDeclaration_ImportedTypeJvmDeclaredTypeCrossReference_1_1_0ElementType());
					}
					ruleQualifiedName
					{
						doneComposite();
					}
				)
			)
			    |
			(
				(
					{
						markComposite(elementTypeProvider.getXImportDeclaration_ImportedNamespaceQualifiedNameWithWildcardParserRuleCall_1_2_0ElementType());
					}
					lv_importedNamespace_7_0=ruleQualifiedNameWithWildcard
					{
						doneComposite();
						if(!$current) {
							associateWithSemanticElement();
							$current = true;
						}
					}
				)
			)
		)
		(
			{
				markLeaf(elementTypeProvider.getXImportDeclaration_SemicolonKeyword_2ElementType());
			}
			otherlv_8=';'
			{
				doneLeaf(otherlv_8);
			}
		)?
	)
;

//Entry rule entryRuleQualifiedNameInStaticImport
entryRuleQualifiedNameInStaticImport returns [Boolean current=false]:
	{ markComposite(elementTypeProvider.getQualifiedNameInStaticImportElementType()); }
	iv_ruleQualifiedNameInStaticImport=ruleQualifiedNameInStaticImport
	{ $current=$iv_ruleQualifiedNameInStaticImport.current; }
	EOF;

// Rule QualifiedNameInStaticImport
ruleQualifiedNameInStaticImport returns [Boolean current=false]
:
	(
		{
			markComposite(elementTypeProvider.getQualifiedNameInStaticImport_ValidIDParserRuleCall_0ElementType());
		}
		ruleValidID
		{
			doneComposite();
		}
		{
			markLeaf(elementTypeProvider.getQualifiedNameInStaticImport_FullStopKeyword_1ElementType());
		}
		kw='.'
		{
			doneLeaf(kw);
		}
	)+
;

RULE_HEX : ('0x'|'0X') ('0'..'9'|'a'..'f'|'A'..'F'|'_')+ ('#' (('b'|'B') ('i'|'I')|('l'|'L')))?;

RULE_INT : '0'..'9' ('0'..'9'|'_')*;

RULE_DECIMAL : RULE_INT (('e'|'E') ('+'|'-')? RULE_INT)? (('b'|'B') ('i'|'I'|'d'|'D')|('l'|'L'|'d'|'D'|'f'|'F'))?;

RULE_ID : '^'? ('a'..'z'|'A'..'Z'|'$'|'_') ('a'..'z'|'A'..'Z'|'$'|'_'|'0'..'9')*;

RULE_STRING : ('"' ('\\' .|~(('\\'|'"')))* '"'?|'\'' ('\\' .|~(('\\'|'\'')))* '\''?);

RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/';

RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')?;

RULE_WS : (' '|'\t'|'\r'|'\n')+;

RULE_ANY_OTHER : .;
