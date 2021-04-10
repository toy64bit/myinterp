%token LPAREN RPAREN
%token <int> INT_LIT
%token <bool> BOOL_LIT
%token PLUS MINUS
%token STAR SLASH
%token LT
%token EOF

%start <Ast.expr> program

%%

program:
  | e=expr EOF { e }

expr:
  | e=cmp_expr { e }

cmp_expr:
  | l=cmp_expr LT r=add_expr { Ast.BinaryOp (Ast.Lt, l, r) }
  | e=add_expr { e }

add_expr:
  | l=add_expr PLUS r=mul_expr { Ast.BinaryOp (Ast.Add, l, r) }
  | l=add_expr MINUS r=mul_expr { Ast.BinaryOp (Ast.Sub, l, r) }
  | e=mul_expr { e }

mul_expr:
  | l=mul_expr STAR r=primary_expr { Ast.BinaryOp (Ast.Mul, l, r) }
  | l=mul_expr SLASH r=primary_expr { Ast.BinaryOp (Ast.Div, l, r) }
  | e=primary_expr { e }

primary_expr:
  | i=INT_LIT { Ast.IntLit i }
  | b=BOOL_LIT { Ast.BoolLit b }
  | LPAREN e=expr RPAREN { e }