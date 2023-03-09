
 CLASS - class_options 





Syntax 

 ... [PUBLIC] 
    [INHERITING FROM superclass] 
    [ABSTRACT] 
    [FINAL] 
    [CREATE {PUBLIC|PROTECTED|PRIVATE}] 
    [SHARED MEMORY ENABLED] 
    [FOR TESTING] 
    [[GLOBAL] FRIENDS class1 class2 ... 
                      intf1  intf2  ...]. 



 Extras: 

 1. ... PUBLIC  

 2. ... INHERITING FROM superclass  

 3. ... ABSTRACT  

 4. ... FINAL  

 5. ... CREATE {PUBLIC|PROTECTED|PRIVATE}  

 6. ... SHARED MEMORY ENABLED  

 7. ... [GLOBAL] FRIENDS class1 class2 ... intf1  intf2 ...  



 Effect 

Defines the properties of a class. A test class for ABAP unit is created with addition FOR TESTING. 


 
 Addition 1 

... PUBLIC 
 

 Effect 

The addition PUBLIC specifies that the class class is a global class in the class library. The addition PUBLIC can only be applied to one class in a class pool. This addition is created by Class Builder when a global class is created. Any class that does not have the addition PUBLIC applied to it is a local class in its program. 



 Notes 
◾ References to public data types can only be made in the public visibility section of a global class. 


◾ Data types and constants declared in the public visibility section of global classes using the statements TYPES and CONSTANTS replace declarations in type groups. 



 
 Addition 2 

... INHERITING FROM superclass 
 

 Effect 

The addition INHERITING FROM specifies that the class class is derived from the superclass superclass and as such is a direct subclass of it. The superclass superclass can be any non-final class that is visible at this point. 

Each class can only have one superclass, but multiple direct subclasses (single inheritance). Every class without the addition INHERITING FROM inherits implicitly from the predefined empty, abstract class object. All classes in ABAP Objects form an inheritance tree, in which there is a unique path from each class to the root object object. 

The class class inherits all components of superclass, without changing their visibility sections. Only the components of public and protected visibility sections are visible in the subclass. The properties of the inherited components cannot be changed. In the subclass, additional components can be declared and inherited methods redefined – that is, they can be reimplemented without the interface being modified. 



 Note 

The public and protected components of all classes in a path in the inheritance tree are in the same namespace. New components in a subclass cannot have the same name as a public or protected component that has been inherited from the superclasses. 


 
 Addition 3 

... ABSTRACT 
 

 Effect 

The addition ABSTRACT defines an abstract class class. No instances can be created from an abstract class. To use the instance components of an abstract class, a concrete subclass of the class must be instantiated. 


 
 Addition 4 

... FINAL 
 

 Effect 

The addition FINAL defines a final class class. No subclasses can be derived from a final class. All methods of a final class are implicitly final and cannot be declared explicitly as final. 



 Note 

In classes that are both abstract and final, only the static components can be used. Although instance components can be declared, they cannot be used. Specifying ABSTRACT and FINAL together therefore is useful only for static classes. 



 Example 

In this example, an abstract class c1 and a final class c2 are defined, such that c2 inherits from c1. c1 is an implicit subclass of the empty class object. In c2, m1 can be accessed but not a1. 

 CLASS c1 DEFINITION ABSTRACT. 
  PROTECTED SECTION. 
    METHODS m1. 
  PRIVATE SECTION. 
    DATA a1 TYPE string VALUE `Attribute A1 of class C1`. 
ENDCLASS. 

CLASS c2 DEFINITION INHERITING FROM c1 FINAL. 
  PUBLIC SECTION. 
    METHODS m2. 
ENDCLASS. 

CLASS c1 IMPLEMENTATION. 
  METHOD m1. 
    cl_demo_output=>display_text( a1 ). 
  ENDMETHOD. 
ENDCLASS. 

CLASS c2 IMPLEMENTATION. 
  METHOD m2. 
    m1( ). 
  ENDMETHOD. 
ENDCLASS. 

DATA oref TYPE REF TO c2. 

START-OF-SELECTION. 

CREATE OBJECT oref. 
oref->m2( ). 

 
   
 Addition 5 

... CREATE {PUBLIC|PROTECTED|PRIVATE} 
 

 Effect 

The addition CREATE specifies the context in which the class class is instantiated – that is, where the statement CREATE OBJECT can be executed for this class and in which visibility section the instance constructor of the class can be declared. 
◾ A class with the addition CREATE PUBLIC can be instantiated anywhere where the class is visible within the framework of the package concept. 


◾ A class with the addition CREATE PROTECTED can only be instantiated in methods of its subclasses, methods of the class itself and methods of its friends. 


◾ A class with the addition CREATE PRIVATE can only be instantiated in methods of the class itself or methods of its friends. This means, in particular, that it cannot be instantiated as an inherited component of subclasses. 


Whether a subclass can be instantiated depends on its immediate superclass: 
◾ Immediate subclasses of object, or classes with the addition CREATE PUBLIC inherit the addition CREATE PUBLIC implicitly. All CREATE additions that then overwrite the inherited addition can be specified explicitly. 


◾ Immediate subclasses of classes with the addition CREATE PROTECTED inherit the addition CREATE PROTECTED implicitly. All CREATE additions that then overwrite the inherited addition can be specified explicitly. 


◾ Immediate subclasses of classes with the addition CREATE PRIVATE that are not friends of the class inherit the addition CREATE NONE implicitly. They cannot be instantiated and no explicit CREATE additions can be specified. Immediate subclasses that are friends of the class inherit the addition CREATE PRIVATE implicitly. All CREATE additions can be specified for all superclasses that can instantiated as private using friends. 


The statement METHODS constructor for the declaration of the instance constructor of a local class can be specified in all visibility sections which are of general instantiability or of the instantiability used in the addition CREATE. For global classes, only a declaration in the public visibility section is feasible, for technical reasons. 



 Notes 
◾ It is best to make a class that can be instantiated as private a final class, since its subclasses cannot be instantiated unless they are friends of the class. 


◾ It is best to declare the instance constructor of local classes in the visibility sector of the class that matches its instantiability, since this enables the components declared there to be used in the constructor interface. 



 
 Addition 6 

... SHARED MEMORY ENABLED 
 

 Effect 

The addition SHARED MEMORY ENABLED defines a shared memory-enabled class whose instances can be stored in shared memory as shared objects. 

The addition SHARED MEMORY ENABLED can only be applied to a subclass if all its superclasses have been defined with this addition. Subclasses do not necessarily inherit this addition from their superclasses. 



 Notes 
◾ The static attributes of a Shared Memory-enabled class are handled in the same way as a normal class, that is they are created in internal session of a program when the class is loaded. If different programs access the same shared objects, the static attributes of the corresponding classes exist multiple times and independently from each other in the programs. 


◾ No events can be declared or handled in a shared-memory-enabled class. The statements [CLASS-]EVENTS and the addition FOR EVENT cannot be specified in the declaration part. 


◾ For global shared memory-enabled classes, the addition SHARED MEMORY ENABLED is assigned by choosing the shared memory-enabled attribute in Class Builder. This applies in particular to the area root class of an area, which is always global. 


◾ This addition should be specified only if it does not cause any problems. Problems occur with shared memory if: 

•The class has static attributes which contain information about all the instances as a whole – such as the total number of instances.
•The class allocates its own memory internally – for example, using kernel methods. 


  
 Addition 7 

... [GLOBAL] FRIENDS class1 class2 ... intf1  intf2 ... 
 

 Effect 

The addition FRIENDS makes the classes class1 class2 ... or the interfaces intf1 intf2 ... friends of the class class. At the same time, all subclasses of the classes class1 class2 ..., all classes that implement one of the interfaces intf1 intf2 ..., and all interfaces that include one of the interfaces intf1 intf2 ... as a component interface become friends of the class class. At least one class or one interface must be specified. 

The friends of a class have unrestricted access to all components of the class, regardless of the visibility section and the addition READ-ONLY. Friends can create instances of the class without any restrictions. 

The friends of class are not automatically made friends of the subclasses of class. The addition FRIENDS does not make the class class a friend of the friends of the other class. 

Without the addition GLOBAL, all classes and interfaces that are visible at this point can be specified for class1 class2... and intf1 intf2 .... If global classes and interfaces from the class library are made friends, make sure that the local classes of ABAP programs are not visible in these global classes. The components of a local class class cannot be accessed statically by these friends. 

The addition GLOBAL is only allowed if the addition PUBLIC is also used – that is, where the class is a global class of a class pool. Other global classes and interfaces from the class library can be specified after GLOBAL FRIENDS. This addition is created when a global class is created by Class Builder if friends are entered on the appropriate tab. 



 Note 

The addition FRIENDS must be specified as the last addition after all other additions. 



 Example 

In this example, the interface i1 and therefore the implementing class c2 are friends of the class c1. The class c2 can instantiate c1 and access its private component a1. 

 INTERFACE i1. 
  ... 
ENDINTERFACE. 

CLASS c1 DEFINITION CREATE PRIVATE FRIENDS i1. 
  PRIVATE SECTION. 
    DATA a1 TYPE c LENGTH 10 VALUE 'Class 1'. 
ENDCLASS. 

CLASS c2 DEFINITION. 
  PUBLIC SECTION. 
    INTERFACES i1. 
    METHODS m2. 
ENDCLASS. 

CLASS c2 IMPLEMENTATION. 
  METHOD m2. 
    DATA oref TYPE REF TO c1. 
    CREATE OBJECT oref. 
    cl_demo_output=>display_text( oref->a1 ). 
  ENDMETHOD. 
ENDCLASS.  





