module Syntax

extend lang::std::Layout;
extend lang::std::Id;

/*
 * Concrete syntax of QL
 */

start syntax Form 
  = "form" Id "{" Question* "}"; 

// TODO: question, computed question, block, if-then-else, if-then
syntax Question
  = String Id":" Type			// normal question
  | String Id":" Type Expr 		// computed question
  | "if (" Bool ") {" Block "}"    // if-then
  | "if (" Bool ") {" Block "} else" Block	// if-then-else 
  ;

syntax Block
  = [Question]*;


// TODO: +, -, *, /, &&, ||, !, >, <, <=, >=, ==, !=, literals (bool, int, str)
// Think about disambiguation using priorities and associativity
// and use C/Java style precedence rules (look it up on the internet)
syntax Expr 
  = var: Id \ "true" \ "false"
  | boolean: Bool boolval // true/false are reserved keywords.
  | \int: Int intval
  | left or: Expr lhs "||" Expr rhs
  > left and: Expr lhs "&&" Expr rhs
  > assoc eq: Expr lhs "==" Expr rhs
  | assoc neq: Expr lhs "!=" Expr rhs
  | non-assoc (
    leq: Expr lhs "\<=" Expr rhs
  | geq: Expr lhs "\>=" Expr rhs
  | gt: Expr lhs "\>" Expr rhs
  | lt: Expr lhs "\<" Expr rhs
  )
  | "!" Expr exp
  > assoc Expr lhs "*" Expr rhs
  | left Expr lhs "/" Expr rhs
  > assoc Expr lhs "+" Expr rhs
  | left Expr lhs "-" Expr rhs
  ;
  
// https://introcs.cs.princeton.edu/java/11precedence/
  
syntax Type
  = boolean: Bool
  | integer: Int
  ;  
  
//lexical Str = [a-zA-Z][a-zA-Z0-9\b\n ?]* \ "true" \ "false";

lexical Int 
  = [1-9][0-9]*
  | [0]
  ;

lexical Bool 
  = "true"
  | "false"
  ;



