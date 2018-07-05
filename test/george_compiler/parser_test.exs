defmodule ParserTest do
  @moduledoc false

  use ExUnit.Case

  test "atribuicao de decimal" do
    assert GeorgeCompiler.Parser.parse!("{ ab := 2 }") == %Tree{
  leafs: [
    %Tree{
      leafs: [%Tree{leafs: [], value: "ab"}, %Tree{leafs: [], value: 2}],
      value: :attrib
    }
  ],
  value: :blk
}
  end

  test "atribuicao de expressoes aritimeticas" do
    assert GeorgeCompiler.Parser.parse!("{ ab := 2 + 2 - -2 / 4 * 5 % 6 }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{leafs: [], value: "ab"},
        %Tree{
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
                        %Tree{leafs: [], value: 4},
                        %Tree{
                          leafs: [
                            %Tree{leafs: [], value: 5},
                            %Tree{leafs: [], value: 6}
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
  ],
  value: :blk
}

  end

  test "atribuicao com expressoes booleanas" do
    assert GeorgeCompiler.Parser.parse!("{ ab := 2 == 2 }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{leafs: [], value: "ab"},
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 2}],
          value: :eq
        }
      ],
      value: :attrib
    }
  ],
  value: :blk
}


    assert GeorgeCompiler.Parser.parse!("{ ab := 2 > 2 }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{leafs: [], value: "ab"},
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 2}],
          value: :gt
        }
      ],
      value: :attrib
    }
  ],
  value: :blk
}



    assert GeorgeCompiler.Parser.parse!("{ ab := 2 < 2 }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{leafs: [], value: "ab"},
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 2}],
          value: :lt
        }
      ],
      value: :attrib
    }
  ],
  value: :blk
}


    assert GeorgeCompiler.Parser.parse!("{ ab := 2 >= 2 }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{leafs: [], value: "ab"},
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 2}],
          value: :ge
        }
      ],
      value: :attrib
    }
  ],
  value: :blk
}


    assert GeorgeCompiler.Parser.parse!("{ ab := 2 <= 2 }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{leafs: [], value: "ab"},
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 2}],
          value: :le
        }
      ],
      value: :attrib
    }
  ],
  value: :blk
}


    assert GeorgeCompiler.Parser.parse!("{ ab := 2 != 2 }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{leafs: [], value: "ab"},
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 2}],
          value: :neq
        }
      ],
      value: :attrib
    }
  ],
  value: :blk
}
  end

  test "and e or" do
    assert GeorgeCompiler.Parser.parse!("{ ab := 2 != 2 or 2 == 2 }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{leafs: [], value: "ab"},
        %Tree{
          leafs: [
            %Tree{leafs: [], value: 2},
            %Tree{
              leafs: [
                %Tree{leafs: [], value: 2},
                %Tree{
                  leafs: [
                    %Tree{leafs: [], value: 2},
                    %Tree{leafs: [], value: 2}
                  ],
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
  ],
  value: :blk
}


    assert GeorgeCompiler.Parser.parse!("{ ab := 2 != 2 and 2 == 2 }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{leafs: [], value: "ab"},
        %Tree{
          leafs: [
            %Tree{leafs: [], value: 2},
            %Tree{
              leafs: [
                %Tree{leafs: [], value: 2},
                %Tree{
                  leafs: [
                    %Tree{leafs: [], value: 2},
                    %Tree{leafs: [], value: 2}
                  ],
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
  ],
  value: :blk
}

  end

  test "if sem bloco" do
    assert GeorgeCompiler.Parser.parse!("{ if (2==2) ab := 1 }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 2}],
          value: :eq
        },
        %Tree{
          leafs: [%Tree{leafs: [], value: "ab"}, %Tree{leafs: [], value: 1}],
          value: :attrib
        }
      ],
      value: :if
    }
  ],
  value: :blk
}
  end

  test "if com bloco" do
    assert GeorgeCompiler.Parser.parse!("{ if (2==2) {ab := 1} }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 2}],
          value: :eq
        },
        %Tree{
          leafs: [
            %Tree{
              leafs: [%Tree{leafs: [], value: "ab"}, %Tree{leafs: [], value: 1}],
              value: :attrib
            }
          ],
          value: :blk
        }
      ],
      value: :if
    }
  ],
  value: :blk
}

  end

  test "else" do
    assert GeorgeCompiler.Parser.parse!("{ if (2==2) {ab := 1} else ab := 2 }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 2}],
          value: :eq
        },
        %Tree{
          leafs: [
            %Tree{
              leafs: [%Tree{leafs: [], value: "ab"}, %Tree{leafs: [], value: 1}],
              value: :attrib
            }
          ],
          value: :blk
        },
        %Tree{
          leafs: [%Tree{leafs: [], value: "ab"}, %Tree{leafs: [], value: 2}],
          value: :attrib
        }
      ],
      value: :if
    }
  ],
  value: :blk
}


    assert GeorgeCompiler.Parser.parse!("{ if (2==2) ab := 1 else { ab := 2 } }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 2}],
          value: :eq
        },
        %Tree{
          leafs: [%Tree{leafs: [], value: "ab"}, %Tree{leafs: [], value: 1}],
          value: :attrib
        },
        %Tree{
          leafs: [
            %Tree{
              leafs: [%Tree{leafs: [], value: "ab"}, %Tree{leafs: [], value: 2}],
              value: :attrib
            }
          ],
          value: :blk
        }
      ],
      value: :if
    }
  ],
  value: :blk
}

  end

  test "while" do
    assert GeorgeCompiler.Parser.parse!("{ while (2==2) do { ab := 2 } }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 2}],
          value: :eq
        },
        %Tree{
          leafs: [
            %Tree{
              leafs: [%Tree{leafs: [], value: "ab"}, %Tree{leafs: [], value: 2}],
              value: :attrib
            }
          ],
          value: :blk
        }
      ],
      value: :while
    }
  ],
  value: :blk
}

  end

  test "bloco com sequencia" do
    assert GeorgeCompiler.Parser.parse!("{ if(2==2) {ab := 2; bc := 3 ; de := 4 } }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{
          leafs: [%Tree{leafs: [], value: 2}, %Tree{leafs: [], value: 2}],
          value: :eq
        },
        %Tree{
          leafs: [
            %Tree{
              leafs: [
                %Tree{
                  leafs: [
                    %Tree{leafs: [], value: "ab"},
                    %Tree{leafs: [], value: 2}
                  ],
                  value: :attrib
                },
                %Tree{
                  leafs: [
                    %Tree{
                      leafs: [
                        %Tree{leafs: [], value: "bc"},
                        %Tree{leafs: [], value: 3}
                      ],
                      value: :attrib
                    },
                    %Tree{
                      leafs: [
                        %Tree{leafs: [], value: "de"},
                        %Tree{leafs: [], value: 4}
                      ],
                      value: :attrib
                    }
                  ],
                  value: :seq
                }
              ],
              value: :seq
            }
          ],
          value: :blk
        }
      ],
      value: :if
    }
  ],
  value: :blk
}

  end

  test "expressoes prioritarias a direita do operadores or / and" do
    assert GeorgeCompiler.Parser.parse!("{ ab := 1 == 1 and (2 == 2 or (2 > 2)) }") == %Tree{
  leafs: [
    %Tree{
      leafs: [
        %Tree{leafs: [], value: "ab"},
        %Tree{
          leafs: [
            %Tree{leafs: [], value: 1},
            %Tree{
              leafs: [
                %Tree{leafs: [], value: 1},
                %Tree{
                  leafs: [
                    %Tree{leafs: [], value: 2},
                    %Tree{
                      leafs: [
                        %Tree{leafs: [], value: 2},
                        %Tree{
                          leafs: [
                            %Tree{leafs: [], value: 2},
                            %Tree{leafs: [], value: 2}
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
  ],
  value: :blk
}

  end


  test "declaração de variáveis" do
    assert GeorgeCompiler.Parser.parse!("{ var x = 1, y = 2, z = 3, w = 7; const u = 4; var v = 5; if(true) x := 0 }") == %Tree{
      value: :blk,
      leafs: [
        %Tree{
          value: :decl,
          leafs: [
            %Tree{leafs: [%Tree{leafs: [], value: "x"}, %Tree{leafs: [], value: 1}], value: :ref},
            %Tree{leafs: [%Tree{leafs: [], value: "y"}, %Tree{leafs: [], value: 2}], value: :ref},
            %Tree{leafs: [%Tree{leafs: [], value: "z"}, %Tree{leafs: [], value: 3}], value: :ref},
            %Tree{leafs: [%Tree{leafs: [], value: "w"}, %Tree{leafs: [], value: 7}], value: :ref},
            %Tree{leafs: [%Tree{leafs: [], value: "u"}, %Tree{leafs: [], value: 4}], value: :cns},
            %Tree{leafs: [%Tree{leafs: [], value: "v"}, %Tree{leafs: [], value: 5}], value: :ref}
          ]},
        %Tree{leafs: [%Tree{leafs: [], value: "true"}, %Tree{leafs: [%Tree{leafs: [], value: "x"}, %Tree{leafs: [], value: 0}], value: :attrib}], value: :if}]}

  end


  test "module" do
    assert GeorgeCompiler.Parser.parse!("
    module Foo
      var x = 0;
      const y = 1;
      proc bar(x,y){
        x:=y
      };
      proc foo(x) {
        bar(1)
      }
    end") == %Tree{
  leafs: [
    %Tree{leafs: [], value: "Foo"},
    %Tree{
      leafs: [
        %Tree{
          leafs: [%Tree{leafs: [], value: "x"}, %Tree{leafs: [], value: 0}],
          value: :ref
        },
        %Tree{
          leafs: [%Tree{leafs: [], value: "y"}, %Tree{leafs: [], value: 1}],
          value: :cns
        }
      ],
      value: :decl
    },
    %Tree{
      leafs: [
        %Tree{
          leafs: [
            %Tree{leafs: [], value: "bar"},
            %Formals{
              items: [%Par{id: "x", type: :int}, %Par{id: "y", type: :int}]
            },
            %Tree{
              leafs: [
                %Tree{
                  leafs: [
                    %Tree{leafs: [], value: "x"},
                    %Tree{leafs: [], value: "y"}
                  ],
                  value: :attrib
                }
              ],
              value: :blk
            }
          ],
          value: :prc
        },
        %Tree{
          leafs: [
            %Tree{leafs: [], value: "foo"},
            %Formals{items: [%Par{id: "x", type: :int}]},
            %Tree{
              leafs: [
                %Tree{
                  leafs: [%Tree{leafs: [], value: "bar"}, %Actuals{items: [1]}],
                  value: :cal
                }
              ],
              value: :blk
            }
          ],
          value: :prc
        }
      ],
      value: :seq
    }
  ],
  value: :mdl
}

  end

  @tag :wip
  test "module_fact" do
     assert GeorgeCompiler.Parser.parse!("
     module FactRec
        var y = 1;
        proc fact(x, z) {
           if (x > 0) {
         		y := y * x - z;
         		fact(x - 1, 0)
           }
        };
     end
     fact(120)
") |> IO.inspect

  end

  test "fun_fact" do
     assert GeorgeCompiler.Parser.parse!("
  module Fact
    var y = 1;
    fun fact(x) {
      while (x != 0) do {
  		  y := y * x;
        x := x - 1
      }
		return y
	  };
  end
  result := fact(x)") == %Tree{
  leafs: [
    %Tree{leafs: [], value: "Fact"},
    %Tree{
      leafs: [
        %Tree{
          leafs: [%Tree{leafs: [], value: "y"}, %Tree{leafs: [], value: 1}],
          value: :ref
        }
      ],
      value: :decl
    },
    %Tree{
      leafs: [
        %Tree{
          leafs: [
            %Tree{leafs: [], value: "fact"},
            %Formals{items: [%Par{id: "x", type: :int}]},
            %Tree{
              leafs: [
                %Tree{
                  leafs: [
                    %Tree{
                      leafs: [
                        %Tree{leafs: [], value: "x"},
                        %Tree{leafs: [], value: 0}
                      ],
                      value: :neq
                    },
                    %Tree{
                      leafs: [
                        %Tree{
                          leafs: [
                            %Tree{
                              leafs: [
                                %Tree{leafs: [], value: "y"},
                                %Tree{
                                  leafs: [
                                    %Tree{leafs: [], value: "y"},
                                    %Tree{leafs: [], value: "x"}
                                  ],
                                  value: :mul
                                }
                              ],
                              value: :attrib
                            },
                            %Tree{
                              leafs: [
                                %Tree{leafs: [], value: "x"},
                                %Tree{
                                  leafs: [
                                    %Tree{leafs: [], value: "x"},
                                    %Tree{leafs: [], value: 1}
                                  ],
                                  value: :sub
                                }
                              ],
                              value: :attrib
                            }
                          ],
                          value: :seq
                        }
                      ],
                      value: :blk
                    }
                  ],
                  value: :while
                },
                %Tree{leafs: ["y"], value: :return}
              ],
              value: :blk
            }
          ],
          value: :fun
        },
        %Tree{
          leafs: [
            %Tree{leafs: [], value: "result"},
            %Tree{
              leafs: [%Tree{leafs: [], value: "fact"}, %Actuals{items: ["x"]}],
              value: :cal
            }
          ],
          value: :attrib
        }
      ],
      value: :seq
    }
  ],
  value: :mdl
}


  end


end
