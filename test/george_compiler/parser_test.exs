defmodule ParserTest do
  @moduledoc false

  use ExUnit.Case


  test "operacoes aritimeticas" do
    assert GeorgeCompiler.Parser.parse!("2 + 2 - -2 + 2 * 3 / 3 % 3" ) == %Tree{
																				  leafs: [
																					%Tree{leafs: [], value: 2},
																					%Tree{
																					  leafs: [
																						%Tree{leafs: [], value: 2},
																						%Tree{
																						  leafs: [
																							%Tree{leafs: [], value: -2},
																							%Tree{
																							  leafs: [
																								%Tree{leafs: [], value: 2},
																								%Tree{
																								  leafs: [
																									%Tree{leafs: [], value: 3},
																									%Tree{
																									  leafs: [
																										%Tree{leafs: [], value: 3},
																										%Tree{leafs: [], value: 3}
																									  ],
																									  value: "rem"
																									}
																								  ],
																								  value: "div"
																								}
																							  ],
																							  value: "mul"
																							}
																						  ],
																						  value: "add"
																						}
																					  ],
																					  value: "sub"
																					}
																				  ],
																				  value: "add"
																				}
  end

  test "operacoes booleanas" do
    assert GeorgeCompiler.Parser.parse!("2 > 3" )  == %Tree{
															  leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 3}],
															  value: "gt"
															}
    assert GeorgeCompiler.Parser.parse!("2 >= 3" )  == %Tree{
															  leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 3}],
															  value: "ge"
															}
    assert GeorgeCompiler.Parser.parse!("-2 == -3" )  == %Tree{
																  leafs: [%Tree{leafs: [], value: -2}, %Tree{leafs: [], value: -3}],
																  value: "eq"
																}
    assert GeorgeCompiler.Parser.parse!("2 < 3" )  == %Tree{
															  leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 3}],
															  value: "lt"
															}
    assert GeorgeCompiler.Parser.parse!("2 <= 3" )  == %Tree{
															  leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 3}],
															  value: "le"
															}
  end

 test "atribuicao simples" do
   assert GeorgeCompiler.Parser.parse!("ab := 2") == %Tree{
													  leafs: [%Tree{leafs: [], value: "ab"}, %Tree{leafs: [], value: 2}],
													  value: "atrib"
}

 end

 test "atribuicao expressoes aritimeticas" do
   assert GeorgeCompiler.Parser.parse!("ab95 := 2 + 3") == %Tree{
																  leafs: [
																	%Tree{leafs: [], value: "ab95"},
																	%Tree{
																	  leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 3}],
																	  value: "add"
																	}
																  ],
																  value: "atrib"
																}
 end

 test "atribuicao expressoes booleanas" do
   assert GeorgeCompiler.Parser.parse!("a10b := 2 > 3" ) == %Tree{
																  leafs: [
																	%Tree{leafs: [], value: "a10b"},
																	%Tree{
																	  leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 3}],
																	  value: "gt"
																	}
																  ],
																  value: "atrib"
																}
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
                                        }")  == %Tree{
													  leafs: [
														%Tree{
														  leafs: [%Tree{leafs: [], value: 1}, %Tree{leafs: [], value: 1}],
														  value: "eq"
														},
														%Tree{
														  leafs: [
															%Tree{leafs: [], value: ["print", [1]]},
															%Tree{
															  leafs: [
																%Tree{
																  leafs: [%Tree{leafs: [], value: "a"}, %Tree{leafs: [], value: 1}],
																  value: "atrib"
																},
																%Tree{
																  leafs: [
																	%Tree{
																	  leafs: [
																		%Tree{leafs: [], value: 2},
																		%Tree{leafs: [], value: 2}
																	  ],
																	  value: "add"
																	},
																	%Tree{
																	  leafs: [
																		%Tree{leafs: [], value: 2},
																		%Tree{leafs: [], value: 2}
																	  ],
																	  value: "gt"
																	}
																  ],
																  value: "seq"
																}
															  ],
															  value: "seq"
															}
														  ],
														  value: "seq"
														},
														%Tree{leafs: [], value: nil}
													  ],
													  value: "if"
													}

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
   assert GeorgeCompiler.Parser.parse!("print(2+2-2--2)" ) == [
																  "print",
																  [
																	%Tree{
																	  leafs: [
																		%Tree{leafs: [], value: 2},
																		%Tree{
																		  leafs: [
																			%Tree{leafs: [], value: 2},
																			%Tree{
																			  leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: -2}],
																			  value: "sub"
																			}
																		  ],
																		  value: "sub"
																		}
																	  ],
																	  value: "add"
																	}
																  ]
																]
 end

 test "exit" do
  assert GeorgeCompiler.Parser.parse!("exit(2+2-2--2)" ) == [
															  [],
															  %Tree{
																leafs: [
																  %Tree{leafs: [], value: 2},
																  %Tree{
																	leafs: [
																	  %Tree{leafs: [], value: 2},
																	  %Tree{
																		leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: -2}],
																		value: "sub"
																	  }
																	],
																	value: "sub"
																  }
																],
																value: "add"
															  }
]
 end

  test "call" do
    assert GeorgeCompiler.Parser.parse!("ab95()" ) == ["ab95", []]
    assert GeorgeCompiler.Parser.parse!("ab95(2 + 2 > 5)" ) == [
																  "ab95",
																  [
																	%Tree{
																	  leafs: [
																		%Tree{leafs: [], value: 2},
																		%Tree{
																		  leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 5}],
																		  value: "gt"
																		}
																	  ],
																	  value: "add"
																	}
																  ]
																]
  end

  test "seq" do
    assert  GeorgeCompiler.Parser.parse!("ab95(2 + 2 > 5) ;
                                          ab95() ;
                                          exit(2+2-2--2) ;
                                          print(2+2-2--2) ;
                                          if (1 == 1) {
                                            print(1) };
                                          ab95 := 10" ) == %Tree{
																  leafs: [
																	%Tree{
																	  leafs: [],
																	  value: [
																		"ab95",
																		[
																		  %Tree{
																			leafs: [
																			  %Tree{leafs: [], value: 2},
																			  %Tree{
																				leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 5}],
																				value: "gt"
																			  }
																			],
																			value: "add"
																		  }
																		]
																	  ]
																	},
																	%Tree{
																	  leafs: [
																		%Tree{leafs: [], value: ["ab95", []]},
																		%Tree{
																		  leafs: [
																			%Tree{
																			  leafs: [],
																			  value: [
																				[],
																				%Tree{
																				  leafs: [
																					%Tree{leafs: [], value: 2},
																					%Tree{
																					  leafs: [
																						%Tree{leafs: [], value: 2},
																						%Tree{
																						  leafs: [
																							%Tree{leafs: [], value: 2},
																							%Tree{leafs: [], value: -2}
																						  ],
																						  value: "sub"
																						}
																					  ],
																					  value: "sub"
																					}
																				  ],
																				  value: "add"
																				}
																			  ]
																			},
																			%Tree{
																			  leafs: [
																				%Tree{
																				  leafs: [],
																				  value: [
																					"print",
																					[
																					  %Tree{
																						leafs: [
																						  %Tree{leafs: [], value: 2},
																						  %Tree{
																							leafs: [
																							  %Tree{leafs: [], value: 2},
																							  %Tree{
																								leafs: [
																								  %Tree{leafs: [], value: 2},
																								  %Tree{leafs: [], value: -2}
																								],
																								value: "sub"
																							  }
																							],
																							value: "sub"
																						  }
																						],
																						value: "add"
																					  }
																					]
																				  ]
																				},
																				%Tree{
																				  leafs: [
																					%Tree{
																					  leafs: [
																						%Tree{
																						  leafs: [
																							%Tree{leafs: [], value: 1},
																							%Tree{leafs: [], value: 1}
																						  ],
																						  value: "eq"
																						},
																						%Tree{leafs: [], value: ["print", [1]]},
																						%Tree{leafs: [], value: nil}
																					  ],
																					  value: "if"
																					},
																					%Tree{
																					  leafs: [
																						%Tree{leafs: [], value: "ab95"},
																						%Tree{leafs: [], value: 10}
																					  ],
																					  value: "atrib"
																					}
																				  ],
																				  value: "seq"
																				}
																			  ],
																			  value: "seq"
																			}
																		  ],
																		  value: "seq"
																		}
																	  ],
																	  value: "seq"
																	}
																  ],
																  value: "seq"
																}
  end

  test "choice" do
    assert  GeorgeCompiler.Parser.parse!("ab95(2 + 2 > 5) |
                                          ab95() ;
                                          exit(2+2-2--2) |
                                          print(2+2-2--2) |
                                          if (1 == 1) {
                                            print(1) } |
                                          ab95 := 10" ) == [
															  [
																"ab95",
																[
																  %Tree{
																	leafs: [
																	  %Tree{leafs: [], value: 2},
																	  %Tree{
																		leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 5}],
																		value: "gt"
																	  }
																	],
																	value: "add"
																  }
																]
															  ],
															  "|",
															  %Tree{
																leafs: [
																  %Tree{leafs: [], value: ["ab95", []]},
																  %Tree{
																	leafs: [],
																	value: [
																	  [
																		[],
																		%Tree{
																		  leafs: [
																			%Tree{leafs: [], value: 2},
																			%Tree{
																			  leafs: [
																				%Tree{leafs: [], value: 2},
																				%Tree{
																				  leafs: [
																					%Tree{leafs: [], value: 2},
																					%Tree{leafs: [], value: -2}
																				  ],
																				  value: "sub"
																				}
																			  ],
																			  value: "sub"
																			}
																		  ],
																		  value: "add"
																		}
																	  ],
																	  "|",
																	  [
																		[
																		  "print",
																		  [
																			%Tree{
																			  leafs: [
																				%Tree{leafs: [], value: 2},
																				%Tree{
																				  leafs: [
																					%Tree{leafs: [], value: 2},
																					%Tree{
																					  leafs: [
																						%Tree{leafs: [], value: 2},
																						%Tree{leafs: [], value: -2}
																					  ],
																					  value: "sub"
																					}
																				  ],
																				  value: "sub"
																				}
																			  ],
																			  value: "add"
																			}
																		  ]
																		],
																		"|",
																		[
																		  %Tree{
																			leafs: [
																			  %Tree{
																				leafs: [
																				  %Tree{leafs: [], value: 1},
																				  %Tree{leafs: [], value: 1}
																				],
																				value: "eq"
																			  },
																			  %Tree{leafs: [], value: ["print", [1]]},
																			  %Tree{leafs: [], value: nil}
																			],
																			value: "if"
																		  },
																		  "|",
																		  %Tree{
																			leafs: [
																			  %Tree{leafs: [], value: "ab95"},
																			  %Tree{leafs: [], value: 10}
																			],
																			value: "atrib"
																		  }
																		]
																	  ]
																	]
																  }
																],
																value: "seq"
															  }
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
