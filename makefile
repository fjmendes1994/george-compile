EXECS=george_compiler

manjaro-install:
	sudo pacman -S elixir

ubuntu-install:
	wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
	sudo dpkg -i erlang-solutions_1.0_all.deb
	sudo apt-get update
	sudo apt-get install esl-erlang
	sudo apt-get install elixir
	rm -rf erlang-solutions_1.0_all.deb

mac-install:
	brew update
	brew install elixir

build:
	mix deps.get
	mix escript.build

run:
	./george_compiler --file=${file}
	./george_compiler --path=${path} --file=${file}

clean:
	rm -f george_compiler
