

# Static call support in Pharo

We extended Pharo's runtime to support static calls in two ways.
First, in the interpreter, by adding a new bytecode and
corresponding syntax.
Second, in the baseline JIT compiler, by reusing dynamic repatching for
monomorphic call sites.

# Baseline
```Smalltalk
Metacello new
baseline: 'StaticCallExp';
repository: 'github://fouziray/staticCalls:main';
load.
```

# How to use

  1 - The syntax is as follows.
  Given ***class A***  that defines method ***foo***.
  you have an object of type ***class B*** that inherits from ***A***.
  The static send site equivalent to the normal send ***B new foo*** is --> ***B new _A_foo***

  2 - The image needs to run on a compiled VM from the pharoVM repository loaded with the baseline. It supports the bytecode 246 which isn't yet merged into the main repository.
  [steps to compile the vm](https://github.com/pharo-project/pharo-vm/wiki/Building) 
