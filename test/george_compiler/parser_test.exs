defmodule ParserTest do
  @moduledoc false

  use ExUnit.Case


  test "operacoes aritimeticas" do
    assert GeorgeCompiler.Parser.parse!("2 + 2 - -2 + 2 * 3 / 3 % 3" ) == ["2", "+", ["2", "-", ["-2", "+", ["2", "*", ["3", "/", ["3", "%", "3"]]]]]]
  end

  test "operacoes booleanas" do
    assert GeorgeCompiler.Parser.parse!("2 > 3" )  == ["2", ">", "3"]
    assert GeorgeCompiler.Parser.parse!("2 >= 3" )  == ["2", ">=", "3"]
    assert GeorgeCompiler.Parser.parse!("-2 == -3" )  == ["-2", "==", "-3"]
    assert GeorgeCompiler.Parser.parse!("2 < 3" )  == ["2", "<", "3"]
    assert GeorgeCompiler.Parser.parse!("2 <= 3" )  == ["2", "<=", "3"]
  end

 test "atribuicao simples" do
   assert GeorgeCompiler.Parser.parse!("ab := 2") == ["ab", ":=", "2"]

 end

 test "atribuicao expressoes aritimeticas" do
   assert GeorgeCompiler.Parser.parse!("ab95 := 2 + 3") == ["ab95", ":=", ["2", "+", "3"]]
 end

 test "atribuicao expressoes booleanas" do
   assert GeorgeCompiler.Parser.parse!("a10b := 2 > 3" ) == ["a10b", ":=", ["2", ">", "3"]]
 end

 test "if sem else sem bloco" do
   assert GeorgeCompiler.Parser.parse!("if (1 == 1)
                                          print(1)") == ["if", ["1", "==", "1"], ["print", "1"], nil]
 end

 test "if sem else com bloco" do
   assert GeorgeCompiler.Parser.parse!("if (1 == 1) {
                                          print(1);
                                          a := 1;
                                          2 + 2;
                                          2 > 2
                                        }")  == [ "if",
                                                                                  ["1", "==", "1"],
                                                                                  [
                                                                                    [
                                                                                      [
                                                                                        ["print", "1"],
                                                                                        ";",
                                                                                        [["a", ":=", "1"], ";", [["2", "+", "2"], ";", ["2", ">", "2"]]]
                                                                                      ]
                                                                                    ]
                                                                                  ],
                                                                                  nil
                                                                                ]

 end

 test "if com else sem bloco" do
   assert GeorgeCompiler.Parser.parse!("if (2 <= 3)
                                          2 + 3
                                        else
                                          if(2 == 2)
                                            ab:=2" ) == [
                                                                                        "if",
                                                                                        ["2", "<=", "3"],
                                                                                        ["2", "+", "3"],
                                                                                        ["else", ["if", ["2", "==", "2"], ["ab", ":=", "2"], nil]]
                                                                                      ]
 end

 test "if com else com bloco" do
   assert GeorgeCompiler.Parser.parse!("if (2 <= 3){
                                          2 + 3;
                                          if (2 <= 3)
                                          3 + 2
                                        }else{
                                          if(2 == 2)
                                            ab:=2;
                                            if (2 <= 3)
                                              3 + 2
                                        }" ) == [
                                                  "if",
                                                  ["2", "<=", "3"],
                                                  [[[["2", "+", "3"], ";", ["if", ["2", "<=", "3"], ["3", "+", "2"], nil]]]],
                                                  [
                                                    "else",
                                                    [
                                                      [
                                                        [
                                                          "if",
                                                          ["2", "==", "2"],
                                                          [
                                                            ["ab", ":=", "2"],
                                                            ";",
                                                            ["if", ["2", "<=", "3"], ["3", "+", "2"], nil]
                                                          ],
                                                          nil
                                                        ]
                                                      ]
                                                    ]
                                                  ]
                                                ]


 end

 test "while com diversos comandos" do
   assert GeorgeCompiler.Parser.parse!("while(1 == 1){
                                         if (2 <= 3){
                                          2 + 3;
                                          if (2 <= 3)
                                            3 + 2
                                          }else{
                                            if(2 == 2)
                                              ab:=2;
                                              if (2 <= 3)
                                                3 + 2
                                          }
                                         }" ) == [
                                                  "while",
                                                  ["1", "==", "1"],
                                                  [
                                                    [
                                                      [
                                                        "if",
                                                        ["2", "<=", "3"],
                                                        [
                                                          [
                                                            [
                                                              ["2", "+", "3"],
                                                              ";",
                                                              ["if", ["2", "<=", "3"], ["3", "+", "2"], nil]
                                                            ]
                                                          ]
                                                        ],
                                                        [
                                                          "else",
                                                          [
                                                            [
                                                              [
                                                                "if",
                                                                ["2", "==", "2"],
                                                                [
                                                                  ["ab", ":=", "2"],
                                                                  ";",
                                                                  ["if", ["2", "<=", "3"], ["3", "+", "2"], nil]
                                                                ],
                                                                nil
                                                              ]
                                                            ]
                                                          ]
                                                        ]
                                                      ]
                                                    ]
                                                  ]
                                                ]
 end

 test "print" do
   assert GeorgeCompiler.Parser.parse!("print(2+2-2--2)" ) == ["print", ["2", "+", ["2", "-", ["2", "-", "-2"]]]]
 end

 test "exit" do
  assert GeorgeCompiler.Parser.parse!("exit(2+2-2--2)" ) == ["exit", ["2", "+", ["2", "-", ["2", "-", "-2"]]]]
 end

  test "call" do
    assert GeorgeCompiler.Parser.parse!("ab95()" ) == ["ab95", []]
    assert GeorgeCompiler.Parser.parse!("ab95(2 + 2 > 5)" ) == ["ab95", [["2", "+", ["2", ">", "5"]]]]
  end

  test "seq" do
    assert  GeorgeCompiler.Parser.parse!("ab95(2 + 2 > 5) ;
                                          ab95() ;
                                          exit(2+2-2--2) ;
                                          print(2+2-2--2) ;
                                          if (1 == 1) {
                                            print(1) };
                                          ab95 := 10" ) == [
                                                            ["ab95", [["2", "+", ["2", ">", "5"]]]],
                                                            ";",
                                                            [
                                                              ["ab95", []],
                                                              ";",
                                                              [
                                                                ["exit", ["2", "+", ["2", "-", ["2", "-", "-2"]]]],
                                                                ";",
                                                                [
                                                                  ["print", ["2", "+", ["2", "-", ["2", "-", "-2"]]]],
                                                                  ";",
                                                                  [
                                                                    ["if", ["1", "==", "1"], [[["print", "1"]]], nil],
                                                                    ";",
                                                                    ["ab95", ":=", "10"]
                                                                  ]
                                                                ]
                                                              ]
                                                            ]
                                                          ]


  end

  test "choice" do
    assert  GeorgeCompiler.Parser.parse!("ab95(2 + 2 > 5) |
                                          ab95() ;
                                          exit(2+2-2--2) |
                                          print(2+2-2--2) |
                                          if (1 == 1) {
                                            print(1) } |
                                          ab95 := 10" ) == [
                                                            ["ab95", [["2", "+", ["2", ">", "5"]]]],
                                                            "|",
                                                            [
                                                              ["ab95", []],
                                                              ";",
                                                              [
                                                                ["exit", ["2", "+", ["2", "-", ["2", "-", "-2"]]]],
                                                                "|",
                                                                [
                                                                  ["print", ["2", "+", ["2", "-", ["2", "-", "-2"]]]],
                                                                  "|",
                                                                  [
                                                                    ["if", ["1", "==", "1"], [[["print", "1"]]], nil],
                                                                    "|",
                                                                    ["ab95", ":=", "10"]
                                                                  ]
                                                                ]
                                                              ]
                                                            ]
                                                          ]


  end

  test "fibonacci_iterativo" do
      assert GeorgeCompiler.Parser.parse!("i := 0;
                                  j := 1;
                                  k := 1;
                                  while (k < n) {
                                    t := i + j;
                                    i := j;
                                    j := t;
                                    k := k + 1
                                  };
                                  print(j)") == [
                                                ["i", ":=", "0"],
                                                ";",
                                                [
                                                  ["j", ":=", "1"],
                                                  ";",
                                                  [
                                                    ["k", ":=", "1"],
                                                    ";",
                                                    [
                                                      [
                                                        "while",
                                                        ["k", "<", "n"],
                                                        [
                                                          [
                                                            [
                                                              ["t", ":=", ["i", "+", "j"]],
                                                              ";",
                                                              [
                                                                ["i", ":=", "j"],
                                                                ";",
                                                                [["j", ":=", "t"], ";", ["k", ":=", ["k", "+", "1"]]]
                                                              ]
                                                            ]
                                                          ]
                                                        ]
                                                      ],
                                                      ";",
                                                      ["print", "j"]
                                                    ]
                                                  ]
                                                ]
                                              ]

  end



end
