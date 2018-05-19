defmodule ParserTest do
  @moduledoc false

  use ExUnit.Case


  test "atribuicao de decimal" do
      assert GeorgeCompiler.Parser.parse!("ab := 2") == %Tree{
                                                                leafs: [%Tree{leafs: [],
                                                                              value: "ab"},
                                                                        %Tree{leafs: [],
                                                                              value: 2}],
                                                                value: :attrib
                                                              }
  end

  test "atribuicao de expressoes aritimeticas" do
    assert GeorgeCompiler.Parser.parse!("ab := 2 + 2 - -2 / 4 * 5 % 6") == %Tree{
                                                                                  leafs: [
                                                                                    %Tree{leafs: [],
                                                                                          value: "ab"},
                                                                                    %Tree{
                                                                                      leafs: [
                                                                                        %Tree{leafs: [],
                                                                                              value: 2},
                                                                                        %Tree{
                                                                                          leafs: [
                                                                                            %Tree{leafs: [],
                                                                                                  value: 2},

                                                                                            %Tree{
                                                                                              leafs: [
                                                                                                %Tree{leafs: [],
                                                                                                      value: -2},
                                                                                                %Tree{
                                                                                                  leafs: [
                                                                                                    %Tree{leafs: [],
                                                                                                          value: 4},
                                                                                                    %Tree{
                                                                                                      leafs: [
                                                                                                        %Tree{leafs: [],
                                                                                                              value: 5},
                                                                                                        %Tree{leafs: [],
                                                                                                              value: 6}
                                                                                                      ],
                                                                                                      value: :rem
                                                                                                    }
                                                                                                  ],
                                                                                                  value: :mul
                                                                                                }
                                                                                              ],
                                                                                              value: :div
                                                                                            }
                                                                                          ],
                                                                                          value: :sub
                                                                                        }
                                                                                      ],
                                                                                      value: :add
                                                                                    }
                                                                                  ],
                                                                                  value: :attrib
                                                                                }
  end

  test "atribuicao com expressoes booleanas" do
    assert GeorgeCompiler.Parser.parse!("ab := 2 == 2") == %Tree{
                                                                  leafs: [
                                                                    %Tree{leafs: [],
                                                                          value: "ab"},
                                                                    %Tree{
                                                                      leafs: [%Tree{leafs: [],
                                                                                    value: 2},
                                                                              %Tree{leafs: [],
                                                                                    value: 2}],
                                                                      value: :eq
                                                                    }
                                                                  ],
                                                                  value: :attrib
                                                                }

    assert GeorgeCompiler.Parser.parse!("ab := 2 > 2") == %Tree{
                                                                 leafs: [
                                                                   %Tree{leafs: [],
                                                                         value: "ab"},
                                                                   %Tree{
                                                                     leafs: [%Tree{leafs: [],
                                                                                   value: 2},
                                                                             %Tree{leafs: [],
                                                                                   value: 2}],
                                                                     value: :gt
                                                                   }
                                                                 ],
                                                                 value: :attrib
                                                               }

    assert GeorgeCompiler.Parser.parse!("ab := 2 < 2") == %Tree{
                                                                 leafs: [
                                                                   %Tree{leafs: [],
                                                                         value: "ab"},
                                                                   %Tree{
                                                                     leafs: [%Tree{leafs: [],
                                                                                   value: 2},
                                                                             %Tree{leafs: [],
                                                                                   value: 2}],
                                                                     value: :lt
                                                                   }
                                                                 ],
                                                                 value: :attrib
                                                               }

    assert GeorgeCompiler.Parser.parse!("ab := 2 >= 2") == %Tree{
                                                                 leafs: [
                                                                   %Tree{leafs: [],
                                                                         value: "ab"},
                                                                   %Tree{
                                                                     leafs: [%Tree{leafs: [],
                                                                                   value: 2},
                                                                             %Tree{leafs: [],
                                                                                   value: 2}],
                                                                     value: :ge
                                                                   }
                                                                 ],
                                                                 value: :attrib
                                                               }

    assert GeorgeCompiler.Parser.parse!("ab := 2 <= 2") == %Tree{
                                                                 leafs: [
                                                                   %Tree{leafs: [],
                                                                         value: "ab"},
                                                                   %Tree{
                                                                     leafs: [%Tree{leafs: [],
                                                                                   value: 2},
                                                                             %Tree{leafs: [],
                                                                                   value: 2}],
                                                                     value: :le
                                                                   }
                                                                 ],
                                                                 value: :attrib
                                                               }

    assert GeorgeCompiler.Parser.parse!("ab := 2 != 2") == %Tree{
                                                                 leafs: [
                                                                   %Tree{leafs: [],
                                                                         value: "ab"},
                                                                   %Tree{
                                                                     leafs: [%Tree{leafs: [],
                                                                                   value: 2},
                                                                             %Tree{leafs: [],
                                                                                   value: 2}],
                                                                     value: :neq
                                                                   }
                                                                 ],
                                                                 value: :attrib
                                                               }
  end

  test "and e or" do
    assert GeorgeCompiler.Parser.parse!("ab := 2 != 2 or 2 == 2") == %Tree{
                                                                           leafs: [
                                                                             %Tree{leafs: [], value: "ab"},
                                                                             %Tree{
                                                                               leafs: [
                                                                                 %Tree{leafs: [],
                                                                                       value: 2},
                                                                                 %Tree{
                                                                                   leafs: [
                                                                                     %Tree{leafs: [],
                                                                                           value: 2},
                                                                                     %Tree{
                                                                                       leafs: [%Tree{leafs: [],
                                                                                                     value: 2},
                                                                                         %Tree{leafs: [],
                                                                                               value: 2}],
                                                                                       value: :eq
                                                                                     }
                                                                                   ],
                                                                                   value: :or
                                                                                 }
                                                                               ],
                                                                               value: :neq
                                                                             }
                                                                           ],
                                                                           value: :attrib
                                                                         }

    assert GeorgeCompiler.Parser.parse!("ab := 2 != 2 and 2 == 2") == %Tree{
                                                                             leafs: [
                                                                               %Tree{leafs: [], value: "ab"},
                                                                               %Tree{
                                                                                 leafs: [
                                                                                   %Tree{leafs: [],
                                                                                         value: 2},
                                                                                   %Tree{
                                                                                     leafs: [
                                                                                       %Tree{leafs: [],
                                                                                             value: 2},
                                                                                       %Tree{
                                                                                         leafs: [%Tree{leafs: [],
                                                                                                       value: 2},
                                                                                                 %Tree{leafs: [],
                                                                                                       value: 2}],
                                                                                         value: :eq
                                                                                       }
                                                                                     ],
                                                                                     value: :and
                                                                                   }
                                                                                 ],
                                                                                 value: :neq
                                                                               }
                                                                             ],
                                                                             value: :attrib
                                                                           }
  end

  test "if sem bloco" do
    assert GeorgeCompiler.Parser.parse!("if (2==2) ab := 1") == %Tree{
                                                                        leafs: [
                                                                          %Tree{
                                                                            leafs: [%Tree{leafs: [],
                                                                                          value: 2},
                                                                                    %Tree{leafs: [],
                                                                                          value: 2}],
                                                                            value: :eq
                                                                          },
                                                                          %Tree{
                                                                            leafs: [%Tree{leafs: [],
                                                                                          value: "ab"},
                                                                                    %Tree{leafs: [],
                                                                                          value: 1}],
                                                                            value: :attrib
                                                                          },
                                                                          %Tree{leafs: [], value: nil}
                                                                        ],
                                                                        value: :if
                                                                      }

  end

  test "if com bloco" do
    assert GeorgeCompiler.Parser.parse!("if (2==2) {ab := 1}") == %Tree{
                                                                      leafs: [
                                                                        %Tree{
                                                                          leafs: [%Tree{leafs: [],
                                                                                        value: 2},
                                                                                  %Tree{leafs: [],
                                                                                        value: 2}],
                                                                          value: :eq
                                                                        },
                                                                        %Tree{
                                                                          leafs: [],
                                                                          value: [
                                                                            %Tree{
                                                                              leafs: [%Tree{leafs: [],
                                                                                            value: "ab"},
                                                                                      %Tree{leafs: [],
                                                                                            value: 1}],
                                                                              value: :attrib
                                                                            }
                                                                          ]
                                                                        },
                                                                        %Tree{leafs: [],
                                                                              value: nil}
                                                                      ],
                                                                      value: :if
                                                                    }
  end

  test "else" do
    assert GeorgeCompiler.Parser.parse!("if (2==2) {ab := 1} else ab := 2") == %Tree{
                                                                                      leafs: [
                                                                                        %Tree{
                                                                                          leafs: [%Tree{leafs: [],
                                                                                                        value: 2},
                                                                                                  %Tree{leafs: [],
                                                                                                        value: 2}],
                                                                                          value: :eq
                                                                                        },
                                                                                        %Tree{
                                                                                          leafs: [],
                                                                                          value: [
                                                                                            %Tree{
                                                                                              leafs: [%Tree{leafs: [],
                                                                                                            value: "ab"},
                                                                                                      %Tree{leafs: [],
                                                                                                            value: 1}],
                                                                                              value: :attrib
                                                                                            }
                                                                                          ]
                                                                                        },
                                                                                        %Tree{
                                                                                          leafs: [%Tree{leafs: [],
                                                                                                        value: "ab"},
                                                                                                  %Tree{leafs: [],
                                                                                                        value: 2}],
                                                                                          value: :attrib
                                                                                        }
                                                                                      ],
                                                                                      value: :if
                                                                                    }


    assert GeorgeCompiler.Parser.parse!("if (2==2) ab := 1 else { ab := 2 }") == %Tree{
                                                                                        leafs: [
                                                                                          %Tree{
                                                                                            leafs: [%Tree{leafs: [],
                                                                                                          value: 2},
                                                                                                    %Tree{leafs: [],
                                                                                                          value: 2}],
                                                                                            value: :eq
                                                                                          },
                                                                                          %Tree{
                                                                                            leafs: [%Tree{leafs: [],
                                                                                                          value: "ab"},
                                                                                                    %Tree{leafs: [],
                                                                                                          value: 1}],
                                                                                            value: :attrib
                                                                                          },
                                                                                          %Tree{
                                                                                            leafs: [],
                                                                                            value: [
                                                                                              %Tree{
                                                                                                leafs: [%Tree{leafs: [],
                                                                                                              value: "ab"},
                                                                                                        %Tree{leafs: [],
                                                                                                              value: 2}],
                                                                                                value: :attrib
                                                                                              }
                                                                                            ]
                                                                                          }
                                                                                        ],
                                                                                        value: :if
                                                                                      }

  end

  test :while do
    assert GeorgeCompiler.Parser.parse!("while (2==2) do { ab := 2 }") == %Tree{
                                                                                 leafs: [
                                                                                   %Tree{
                                                                                     leafs: [%Tree{leafs: [],
                                                                                                   value: 2},
                                                                                             %Tree{leafs: [],
                                                                                                   value: 2}],
                                                                                     value: :eq
                                                                                   },
                                                                                   %Tree{
                                                                                     leafs: [%Tree{leafs: [],
                                                                                                   value: "ab"},
                                                                                             %Tree{leafs: [],
                                                                                                   value: 2}],
                                                                                     value: :attrib
                                                                                   }
                                                                                 ],
                                                                                 value: :while
                                                                               }

  end

  test "bloco com sequencia" do
    assert GeorgeCompiler.Parser.parse!("if(2==2) {ab := 2; bc := 3 ; de := 4}") == %Tree{
                                                                                           leafs: [
                                                                                             %Tree{
                                                                                               leafs: [%Tree{leafs: [],
                                                                                                             value: 2},
                                                                                                       %Tree{leafs: [],
                                                                                                             value: 2}],
                                                                                               value: :eq
                                                                                             },
                                                                                             %Tree{
                                                                                               leafs: [],
                                                                                               value: [
                                                                                                 %Tree{
                                                                                                   leafs: [
                                                                                                     %Tree{
                                                                                                       leafs: [%Tree{leafs: [],
                                                                                                                     value: "ab"},
                                                                                                               %Tree{leafs: [],
                                                                                                                     value: 2}],
                                                                                                       value: :attrib
                                                                                                     },
                                                                                                     %Tree{
                                                                                                       leafs: [
                                                                                                         %Tree{
                                                                                                           leafs: [
                                                                                                             %Tree{leafs: [],
                                                                                                                   value: "bc"},
                                                                                                             %Tree{leafs: [],
                                                                                                                   value: 3}
                                                                                                           ],
                                                                                                           value: :attrib
                                                                                                         },
                                                                                                         %Tree{
                                                                                                           leafs: [
                                                                                                             %Tree{leafs: [],
                                                                                                                   value: "de"},
                                                                                                             %Tree{leafs: [],
                                                                                                                   value: 4}
                                                                                                           ],
                                                                                                           value: :attrib
                                                                                                         }
                                                                                                       ],
                                                                                                       value: :seq
                                                                                                     }
                                                                                                   ],
                                                                                                   value: :seq
                                                                                                 }
                                                                                               ]
                                                                                             },
                                                                                             %Tree{leafs: [],
                                                                                                   value: nil}
                                                                                           ],
                                                                                           value: :if
                                                                                         }
  end

  test "expressoes prioritarias a direita do operadores or / and" do
    assert GeorgeCompiler.Parser.parse!("ab := 1 == 1 and (2 == 2 or (2 > 2))") == %Tree{
                                                                                          leafs: [
                                                                                            %Tree{leafs: [],
                                                                                                  value: "ab"},
                                                                                            %Tree{
                                                                                              leafs: [
                                                                                                %Tree{leafs: [],
                                                                                                      value: 1},
                                                                                                %Tree{
                                                                                                  leafs: [
                                                                                                    %Tree{leafs: [],
                                                                                                          value: 1},
                                                                                                    %Tree{
                                                                                                      leafs: [
                                                                                                        %Tree{leafs: [],
                                                                                                              value: 2},
                                                                                                        %Tree{
                                                                                                          leafs: [
                                                                                                            %Tree{leafs: [],
                                                                                                                  value: 2},
                                                                                                            %Tree{
                                                                                                              leafs: [
                                                                                                                %Tree{leafs: [],
                                                                                                                      value: 2},
                                                                                                                %Tree{leafs: [],
                                                                                                                      value: 2}
                                                                                                              ],
                                                                                                              value: :gt
                                                                                                            }
                                                                                                          ],
                                                                                                          value: :or
                                                                                                        }
                                                                                                      ],
                                                                                                      value: :eq
                                                                                                    }
                                                                                                  ],
                                                                                                  value: :and
                                                                                                }
                                                                                              ],
                                                                                              value: :eq
                                                                                            }
                                                                                          ],
                                                                                          value: :attrib
                                                                                        }

  end

  test "declaração de variáveis" do
  assert GeorgeCompiler.Parser.parse!("var x = 2") == %Tree{
  leafs: [
    %Tree{
      leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: nil}],
      value: "x"
    }
  ],
  value: :ref
}

  assert GeorgeCompiler.Parser.parse!("var x = 2 + 5, y = 8, z = 7") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 5}],
          value: :add
        },
        %Tree{
          leafs: [],
          value: [
            %Tree{
              leafs: [
                %Tree{leafs: [], value: 8},
                %Tree{
                  leafs: [],
                  value: [
                    %Tree{
                      leafs: [
                        %Tree{leafs: [], value: 7},
                        %Tree{leafs: [], value: nil}
                      ],
                      value: "z"
                    }
                  ]
                }
              ],
              value: "y"
            }
          ]
        }
      ],
      value: "x"
    }
  ],
  value: :ref
}


  assert GeorgeCompiler.Parser.parse!("const x = 6") == %Tree{
  leafs: [
    %Tree{
      leafs: [%Tree{leafs: [], value: 6}, %Tree{leafs: [], value: nil}],
      value: "x"
    }
  ],
  value: :cns
}

  assert GeorgeCompiler.Parser.parse!("const x = 6 >= 5, y = 8 < 17") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{
          leafs: [%Tree{leafs: [], value: 6}, %Tree{leafs: [], value: 5}],
          value: :ge
        },
        %Tree{
          leafs: [],
          value: [
            %Tree{
              leafs: [
                %Tree{
                  leafs: [
                    %Tree{leafs: [], value: 8},
                    %Tree{leafs: [], value: 17}
                  ],
                  value: :lt
                },
                %Tree{leafs: [], value: nil}
              ],
              value: "y"
            }
          ]
        }
      ],
      value: "x"
    }
  ],
  value: :cns
}
  end
  
end
