Haven Resource 1; src �  Pig.java /* Preprocessed source code */
/* $use: ui/croster */

import haven.*;
import haven.res.ui.croster.*;
import java.util.*;

public class Pig extends Entry {
    public int meat, milk;
    public int meatq, milkq, hideq;
    public int seedq;
    public int prc;
    public boolean hog, piglet, dead, pregnant, lactate;

    public Pig(long id, String name) {
	super(SIZE, id, name);
    }

    public void draw(GOut g) {
	drawbg(g);
	int i = 0;
	drawcol(g, PigRoster.cols.get(i), 0, this, namerend, i++);
	drawcol(g, PigRoster.cols.get(i), 0.5, hog,      sex, i++);
	drawcol(g, PigRoster.cols.get(i), 0.5, piglet,   growth, i++);
	drawcol(g, PigRoster.cols.get(i), 0.5, dead,     deadrend, i++);
	drawcol(g, PigRoster.cols.get(i), 0.5, pregnant, pregrend, i++);
	drawcol(g, PigRoster.cols.get(i), 0.5, lactate,  lactrend, i++);
	drawcol(g, PigRoster.cols.get(i), 1, q, quality, i++);
	drawcol(g, PigRoster.cols.get(i), 1, prc, null, i++);
	drawcol(g, PigRoster.cols.get(i), 1, meat, null, i++);
	drawcol(g, PigRoster.cols.get(i), 1, milk, null, i++);
	drawcol(g, PigRoster.cols.get(i), 1, meatq, percent, i++);
	drawcol(g, PigRoster.cols.get(i), 1, milkq, percent, i++);
	drawcol(g, PigRoster.cols.get(i), 1, hideq, percent, i++);
	drawcol(g, PigRoster.cols.get(i), 1, seedq, null, i++);
	super.draw(g);
    }

    public boolean mousedown(Coord c, int button) {
	if(PigRoster.cols.get(1).hasx(c.x)) {
	    markall(Pig.class, o -> (o.hog == this.hog));
	    return(true);
	}
	if(PigRoster.cols.get(2).hasx(c.x)) {
	    markall(Pig.class, o -> (o.piglet == this.piglet));
	    return(true);
	}
	if(PigRoster.cols.get(3).hasx(c.x)) {
	    markall(Pig.class, o -> (o.dead == this.dead));
	    return(true);
	}
	if(PigRoster.cols.get(4).hasx(c.x)) {
	    markall(Pig.class, o -> (o.pregnant == this.pregnant));
	    return(true);
	}
	if(PigRoster.cols.get(5).hasx(c.x)) {
	    markall(Pig.class, o -> (o.lactate == this.lactate));
	    return(true);
	}
	return(super.mousedown(c, button));
    }
}

/* >wdg: PigRoster */
src   PigRoster.java /* Preprocessed source code */
/* $use: ui/croster */

import haven.*;
import haven.res.ui.croster.*;
import java.util.*;

public class PigRoster extends CattleRoster<Pig> {
    public static List<Column> cols = initcols(
	new Column<Entry>("Name", Comparator.comparing((Entry e) -> e.name), 200),

	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/sex", 2),      Comparator.comparing((Pig e) -> e.hog).reversed(), 20).runon(),
	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/growth", 2),   Comparator.comparing((Pig e) -> e.piglet).reversed(), 20).runon(),
	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/deadp", 3),    Comparator.comparing((Pig e) -> e.dead).reversed(), 20).runon(),
	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/pregnant", 2), Comparator.comparing((Pig e) -> e.pregnant).reversed(), 20).runon(),
	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/lactate", 1),  Comparator.comparing((Pig e) -> e.lactate).reversed(), 20),

	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/quality", 2), Comparator.comparing((Pig e) -> e.q).reversed()),

	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/trufflesnout", 1), Comparator.comparing((Pig e) -> e.prc).reversed()),

	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/meatquantity", 1), Comparator.comparing((Pig e) -> e.meat).reversed()),
	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/milkquantity", 1), Comparator.comparing((Pig e) -> e.milk).reversed()),

	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/meatquality", 1), Comparator.comparing((Pig e) -> e.meatq).reversed()),
	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/milkquality", 1), Comparator.comparing((Pig e) -> e.milkq).reversed()),
	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/hidequality", 1), Comparator.comparing((Pig e) -> e.hideq).reversed()),

	new Column<Pig>(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/breedingquality", 1), Comparator.comparing((Pig e) -> e.seedq).reversed())
    );
    protected List<Column> cols() {return(cols);}

    public static CattleRoster mkwidget(UI ui, Object... args) {
	return(new PigRoster());
    }

    public Pig parse(Object... args) {
	int n = 0;
	long id = (Long)args[n++];
	String name = (String)args[n++];
	Pig ret = new Pig(id, name);
	ret.grp = (Integer)args[n++];
	int fl = (Integer)args[n++];
	ret.hog = (fl & 1) != 0;
	ret.piglet = (fl & 2) != 0;
	ret.dead = (fl & 4) != 0;
	ret.pregnant = (fl & 8) != 0;
	ret.lactate = (fl & 16) != 0;
	ret.q = ((Number)args[n++]).doubleValue();
	ret.meat = (Integer)args[n++];
	ret.milk = (Integer)args[n++];
	ret.meatq = (Integer)args[n++];
	ret.milkq = (Integer)args[n++];
	ret.hideq = (Integer)args[n++];
	ret.seedq = (Integer)args[n++];
	ret.prc = (Integer)args[n++];
	return(ret);
    }

    public TypeButton button() {
	return(typebtn(Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/btn-pig", 2),
		       Resource.classres(PigRoster.class).pool.load("gfx/hud/rosters/btn-pig-d", 2)));
    }
}
code �  Pig ����   4 �	 % M
 - N
 % O	 P Q R S T	 % U
 % V?�      	 % W
 X Y	 % Z	 % [	 % \	 % ]	 % ^	 % _	 % `	 % a	 % b	 % c
 d e	 % f	 % g
 h i	 % j	 % k	 % l	 % m	 % n	 % o	 % p
 - q	 r s
  t u   {
 % |  {  {  {  {
 - � � meat I milk meatq milkq hideq seedq prc hog Z piglet dead pregnant lactate <init> (JLjava/lang/String;)V Code LineNumberTable draw (Lhaven/GOut;)V 	mousedown (Lhaven/Coord;I)Z StackMapTable lambda$mousedown$4 (LPig;)Z lambda$mousedown$3 lambda$mousedown$2 lambda$mousedown$1 lambda$mousedown$0 
SourceFile Pig.java � � < � � A � � � � � � haven/res/ui/croster/Column � � � � 6 7 � � � � � 8 7 � � 9 7 � � : 7 � � ; 7 � � � � � � � � � 5 / � � � . / 0 / 1 / � � 2 / 3 / 4 / @ A � � / � � Pig BootstrapMethods � � � F � � � � � � � � B C haven/res/ui/croster/Entry SIZE Lhaven/Coord; #(Lhaven/Coord;JLjava/lang/String;)V drawbg 	PigRoster cols Ljava/util/List; java/util/List get (I)Ljava/lang/Object; namerend Ljava/util/function/Function; drawcol ](Lhaven/GOut;Lhaven/res/ui/croster/Column;DLjava/lang/Object;Ljava/util/function/Function;I)V java/lang/Boolean valueOf (Z)Ljava/lang/Boolean; sex growth deadrend pregrend lactrend q D java/lang/Double (D)Ljava/lang/Double; quality java/lang/Integer (I)Ljava/lang/Integer; percent haven/Coord x hasx (I)Z
 � � (Ljava/lang/Object;)Z
 % � test %(LPig;)Ljava/util/function/Predicate; markall 2(Ljava/lang/Class;Ljava/util/function/Predicate;)V
 % �
 % �
 % �
 % � � � � J F I F H F G F E F "java/lang/invoke/LambdaMetafactory metafactory � Lookup InnerClasses �(Ljava/lang/invoke/MethodHandles$Lookup;Ljava/lang/String;Ljava/lang/invoke/MethodType;Ljava/lang/invoke/MethodType;Ljava/lang/invoke/MethodHandle;Ljava/lang/invoke/MethodType;)Ljava/lang/invoke/CallSite; � %java/lang/invoke/MethodHandles$Lookup java/lang/invoke/MethodHandles 	pig.cjava ! % -     . /    0 /    1 /    2 /    3 /    4 /    5 /    6 7    8 7    9 7    : 7    ; 7     < =  >   &     
*� -� �    ?   
     	   @ A  >  %    �*+� =*+� �  � *� �� *+� �  �  	*� � � �� *+� �  �  	*� � � �� *+� �  �  	*� � � �� *+� �  �  	*� � � �� *+� �  �  	*� � � �� *+� �  � *� � � �� *+� �  � *� � �� *+� �  � *� � �� *+� �  � *� � �� *+� �  � *� � � �� *+� �  � *� � � �� *+� �  � *�  � � �� *+� �  � *� !� �� *+� "�    ?   J         !  C  e  �  �  �  � 	 ' E e  � !� "� #� $  B C  >       �� �  � +� #� $� *%*� &  � '�� �  � +� #� $� *%*� (  � '�� �  � +� #� $� *%*� )  � '�� �  � +� #� $� *%*� *  � '�� �  � +� #� $� *%*� +  � '�*+� ,�    D    $#### ?   B    '  ( " ) $ + : , F - H / ^ 0 j 1 l 3 � 4 � 5 � 7 � 8 � 9 � ; E F  >   4     +� *� � � �    D    @ ?       8 G F  >   4     +� *� � � �    D    @ ?       4 H F  >   4     +� *� � � �    D    @ ?       0 I F  >   4     +� *� � � �    D    @ ?       , J F  >   4     +� *� � � �    D    @ ?       (  v   4  w  x y z w  x } z w  x ~ z w  x  z w  x � z K    � �   
  � � � code   PigRoster ����   48
 K x	  y z
  x {
  | } ~
   �
 
 �	  �	  �	  �	  �	  �	  � �
  �	  �	  �	  �	  �	  �	  �	  �	  �
 � �	 � � �
 � � �
  �
  �
 
 �
 � �
 � �	 � � � �   � � �
 ' � �  � � �
 ' �
 ' � �  � �  � �  � �  � �  �
 ' � �  � �  � � 	 � � 
 � �  � �  � �  �
  � � cols Ljava/util/List; 	Signature /Ljava/util/List<Lhaven/res/ui/croster/Column;>; <init> ()V Code LineNumberTable ()Ljava/util/List; 1()Ljava/util/List<Lhaven/res/ui/croster/Column;>; mkwidget B(Lhaven/UI;[Ljava/lang/Object;)Lhaven/res/ui/croster/CattleRoster; parse ([Ljava/lang/Object;)LPig; StackMapTable z � } ~ button #()Lhaven/res/ui/croster/TypeButton; 1([Ljava/lang/Object;)Lhaven/res/ui/croster/Entry; lambda$static$13 (LPig;)Ljava/lang/Integer; lambda$static$12 lambda$static$11 lambda$static$10 lambda$static$9 lambda$static$8 lambda$static$7 lambda$static$6 (LPig;)Ljava/lang/Double; lambda$static$5 (LPig;)Ljava/lang/Boolean; lambda$static$4 lambda$static$3 lambda$static$2 lambda$static$1 lambda$static$0 0(Lhaven/res/ui/croster/Entry;)Ljava/lang/String; <clinit> *Lhaven/res/ui/croster/CattleRoster<LPig;>; 
SourceFile PigRoster.java P Q L M 	PigRoster java/lang/Long � � java/lang/String Pig P � java/lang/Integer � � � � � � � � � � � � � � java/lang/Number � � � � � � � � � � � � � � � � � � � � � � � gfx/hud/rosters/btn-pig � � � gfx/hud/rosters/btn-pig-d � � X Y � � � � � � � � � � � haven/res/ui/croster/Column Name BootstrapMethods  s P gfx/hud/rosters/sex	 m
 P gfx/hud/rosters/growth gfx/hud/rosters/deadp gfx/hud/rosters/pregnant gfx/hud/rosters/lactate gfx/hud/rosters/quality k P gfx/hud/rosters/trufflesnout c gfx/hud/rosters/meatquantity gfx/hud/rosters/milkquantity gfx/hud/rosters/meatquality gfx/hud/rosters/milkquality gfx/hud/rosters/hidequality gfx/hud/rosters/breedingquality !haven/res/ui/croster/CattleRoster [Ljava/lang/Object; 	longValue ()J (JLjava/lang/String;)V intValue ()I grp I hog Z piglet dead pregnant lactate doubleValue ()D q D meat milk meatq milkq hideq seedq prc haven/Resource classres #(Ljava/lang/Class;)Lhaven/Resource; pool Pool InnerClasses Lhaven/Resource$Pool; haven/Resource$Pool load Named +(Ljava/lang/String;I)Lhaven/Resource$Named; typebtn =(Lhaven/Indir;Lhaven/Indir;)Lhaven/res/ui/croster/TypeButton; valueOf (I)Ljava/lang/Integer; java/lang/Double (D)Ljava/lang/Double; java/lang/Boolean (Z)Ljava/lang/Boolean; haven/res/ui/croster/Entry name Ljava/lang/String;
  &(Ljava/lang/Object;)Ljava/lang/Object;
 ! apply ()Ljava/util/function/Function; java/util/Comparator 	comparing 5(Ljava/util/function/Function;)Ljava/util/Comparator; ,(Ljava/lang/String;Ljava/util/Comparator;I)V
 " reversed ()Ljava/util/Comparator; '(Lhaven/Indir;Ljava/util/Comparator;I)V runon ()Lhaven/res/ui/croster/Column;
 #
 $
 %
 &
 ' &(Lhaven/Indir;Ljava/util/Comparator;)V
 (
 )
 *
 +
 ,
 -
 . initcols 0([Lhaven/res/ui/croster/Column;)Ljava/util/List; haven/Resource$Named/03 r s q m p m o m n m l m j k i c h c g c f c e c d c b c "java/lang/invoke/LambdaMetafactory metafactory5 Lookup �(Ljava/lang/invoke/MethodHandles$Lookup;Ljava/lang/String;Ljava/lang/invoke/MethodType;Ljava/lang/invoke/MethodType;Ljava/lang/invoke/MethodHandle;Ljava/lang/invoke/MethodType;)Ljava/lang/invoke/CallSite;6 %java/lang/invoke/MethodHandles$Lookup java/lang/invoke/MethodHandles 	pig.cjava !  K    	 L M  N    O   P Q  R        *� �    S       @  L T  R        � �    S       W N    U � V W  R         � Y� �    S       Z � X Y  R  >    '=+�2� � B+�2� :� Y!� 	:+�2� 
� � +�2� 
� 6~� � � ~� � � ~� � � ~� � � ~� � � +�2� � � +�2� 
� � +�2� 
� � +�2� 
� � +�2� 
� � +�2� 
� � +�2� 
� � +�2� 
� � �    Z   � 
� R  [ \ ] ^  ^�    [ \ ] ^  ^O ^�    [ \ ] ^  ^O ^�    [ \ ] ^  ^P ^�    [ \ ] ^  ^P ^�    [ \ ] ^  ^ S   R    ^  _  `  a & b 7 c E d V e g f x g � h � i � j � k � l � m � n o p$ q  _ `  R   @      � � � � �  � � !�    S       u  v  uA X a  R        *+� "�    S       @
 b c  R         *� � #�    S       U
 d c  R         *� � #�    S       S
 e c  R         *� � #�    S       R
 f c  R         *� � #�    S       Q
 g c  R         *� � #�    S       O
 h c  R         *� � #�    S       N
 i c  R         *� � #�    S       L
 j k  R         *� � $�    S       J
 l m  R         *� � %�    S       H
 n m  R         *� � %�    S       G
 o m  R         *� � %�    S       F
 p m  R         *� � %�    S       E
 q m  R         *� � %�    S       D
 r s  R        *� &�    S       B  t Q  R  v     "� 'Y� 'Y(� )  � * ȷ +SY� 'Y� � ,� � -  � *� . � /� 0SY� 'Y� � 1� � 2  � *� . � /� 0SY� 'Y� � 3� � 4  � *� . � /� 0SY� 'Y� � 5� � 6  � *� . � /� 0SY� 'Y� � 7� � 8  � *� . � /SY� 'Y� � 9� � :  � *� . � ;SY� 'Y� � <� � =  � *� . � ;SY� 'Y� � >� � ?  � *� . � ;SY	� 'Y� � @� � A  � *� . � ;SY
� 'Y� � B� � C  � *� . � ;SY� 'Y� � D� � E  � *� . � ;SY� 'Y� � F� � G  � *� . � ;SY� 'Y� � H� � I  � *� . � ;S� J� �    S   B    A  B $ D N E x F � G � H � J L@ Nf O� Q� R� S� U A  �   �  �  � � � �  � � � �  � � � �  � � � �  � � � �  � � � �  � � � �  � � � �  � � � �  � � � �  � � � �  � � � �  � � � �  � � � v   7 N    u �     � � � 	 � � �	142 codeentry     wdg PigRoster   ui/croster G  