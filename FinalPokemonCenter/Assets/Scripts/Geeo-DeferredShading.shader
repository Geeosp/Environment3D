S h a d e r   " G e e o / D e f e r r e d S h a d i n g "   { 
 P r o p e r t i e s   { 
 	 _ L i g h t T e x t u r e 0   ( " " ,   a n y )   =   " "   { } 
 	 _ L i g h t T e x t u r e B 0   ( " " ,   2 D )   =   " "   { } 
 	 _ S h a d o w M a p T e x t u r e   ( " " ,   a n y )   =   " "   { } 
 	 _ S r c B l e n d   ( " " ,   F l o a t )   =   1 
 	 _ D s t B l e n d   ( " " ,   F l o a t )   =   1 
 } 
 S u b S h a d e r   { 
 
 / /   P a s s   1 :   L i g h t i n g   p a s s 
 / /     L D R   c a s e   -   L i g h t i n g   e n c o d e d   i n t o   a   s u b t r a c t i v e   A R G B 8   b u f f e r 
 / /     H D R   c a s e   -   L i g h t i n g   a d d i t i v e l y   b l e n d e d   i n t o   f l o a t i n g   p o i n t   b u f f e r 
 P a s s   { 
 	 Z W r i t e   O f f 
 	 B l e n d   [ _ S r c B l e n d ]   [ _ D s t B l e n d ] 
 
 C G P R O G R A M 
 # p r a g m a   t a r g e t   3 . 0 
 # p r a g m a   v e r t e x   v e r t _ d e f e r r e d 
 # p r a g m a   f r a g m e n t   f r a g 
 # p r a g m a   m u l t i _ c o m p i l e _ l i g h t p a s s 
 # p r a g m a   m u l t i _ c o m p i l e   _ _ _   U N I T Y _ H D R _ O N 
 
 # p r a g m a   e x c l u d e _ r e n d e r e r s   n o m r t 
 
 # i n c l u d e   " U n i t y C G . c g i n c " 
 # i n c l u d e   " U n i t y D e f e r r e d L i b r a r y . c g i n c " 
 # i n c l u d e   " U n i t y P B S L i g h t i n g . c g i n c " 
 # i n c l u d e   " U n i t y S t a n d a r d U t i l s . c g i n c " 
 # i n c l u d e   " U n i t y S t a n d a r d B R D F . c g i n c " 
 
 s a m p l e r 2 D   _ C a m e r a G B u f f e r T e x t u r e 0 ; 
 s a m p l e r 2 D   _ C a m e r a G B u f f e r T e x t u r e 1 ; 
 s a m p l e r 2 D   _ C a m e r a G B u f f e r T e x t u r e 2 ; 
 	 	 
 h a l f 4   C a l c u l a t e L i g h t   ( u n i t y _ v 2 f _ d e f e r r e d   i ) 
 { 
 	 f l o a t 3   w p o s ; 
 	 f l o a t 2   u v ; 
 	 f l o a t   a t t e n ,   f a d e D i s t ; 
 	 U n i t y L i g h t   l i g h t ; 
 	 U N I T Y _ I N I T I A L I Z E _ O U T P U T ( U n i t y L i g h t ,   l i g h t ) ; 
 	 U n i t y D e f e r r e d C a l c u l a t e L i g h t P a r a m s   ( i ,   w p o s ,   u v ,   l i g h t . d i r ,   a t t e n ,   f a d e D i s t ) ; 
 
 	 h a l f 4   g b u f f e r 0   =   t e x 2 D   ( _ C a m e r a G B u f f e r T e x t u r e 0 ,   u v ) ; 
 	 h a l f 4   g b u f f e r 1   =   t e x 2 D   ( _ C a m e r a G B u f f e r T e x t u r e 1 ,   u v ) ; 
 	 h a l f 4   g b u f f e r 2   =   t e x 2 D   ( _ C a m e r a G B u f f e r T e x t u r e 2 ,   u v ) ; 
 
 	 l i g h t . c o l o r   =   _ L i g h t C o l o r . r g b   *   a t t e n ; 
 	 h a l f 3   b a s e C o l o r   =   g b u f f e r 0 . r g b ; 
 	 h a l f 3   s p e c C o l o r   =   g b u f f e r 1 . r g b ; 
 	 h a l f   o n e M i n u s R o u g h n e s s   =   g b u f f e r 1 . a ; 
 	 h a l f 3   n o r m a l W o r l d   =   g b u f f e r 2 . r g b   *   2   -   1 ; 
 	 n o r m a l W o r l d   =   n o r m a l i z e ( n o r m a l W o r l d ) ; 
 	 f l o a t 3   e y e V e c   =   n o r m a l i z e ( w p o s - _ W o r l d S p a c e C a m e r a P o s ) ; 
 	 h a l f   o n e M i n u s R e f l e c t i v i t y   =   1   -   S p e c u l a r S t r e n g t h ( s p e c C o l o r . r g b ) ; 
 	 l i g h t . n d o t l   =   L a m b e r t T e r m   ( n o r m a l W o r l d ,   l i g h t . d i r ) ; 
 
 	 U n i t y I n d i r e c t   i n d ; 
 	 U N I T Y _ I N I T I A L I Z E _ O U T P U T ( U n i t y I n d i r e c t ,   i n d ) ; 
 	 i n d . d i f f u s e   =   0 ; 
 	 i n d . s p e c u l a r   =   0 ; 
 
         h a l f 4   r e s   =   U N I T Y _ B R D F _ P B S   ( b a s e C o l o r ,   s p e c C o l o r ,   o n e M i n u s R e f l e c t i v i t y ,   o n e M i n u s R o u g h n e s s ,   n o r m a l W o r l d ,   - e y e V e c ,   l i g h t ,   i n d ) ; 
 
 	 r e t u r n   r e s ; 
 } 
 
 # i f d e f   U N I T Y _ H D R _ O N 
 h a l f 4 
 # e l s e 
 f i x e d 4 
 # e n d i f 
 f r a g   ( u n i t y _ v 2 f _ d e f e r r e d   i )   :   S V _ T a r g e t 
 { 
 	 h a l f 4   c   =   C a l c u l a t e L i g h t ( i ) ; 
 	 # i f d e f   U N I T Y _ H D R _ O N 
 	 r e t u r n   c ; 
 	 # e l s e 
 	 r e t u r n   e x p 2 ( - c ) ; 
 	 # e n d i f 
 } 
 
 E N D C G 
 } 
 
 
 / /   P a s s   2 :   F i n a l   d e c o d e   p a s s . 
 / /   U s e d   o n l y   w i t h   H D R   o f f ,   t o   d e c o d e   t h e   l o g a r i t h m i c   b u f f e r   i n t o   t h e   m a i n   R T 
 P a s s   { 
 	 Z T e s t   A l w a y s   C u l l   O f f   Z W r i t e   O f f 
 	 S t e n c i l   { 
 	 	 r e f   [ _ S t e n c i l N o n B a c k g r o u n d ] 
 	 	 r e a d m a s k   [ _ S t e n c i l N o n B a c k g r o u n d ] 
 	 	 / /   N o r m a l l y   j u s t   c o m p   w o u l d   b e   s u f f i c i e n t ,   b u t   t h e r e ' s   a   b u g   a n d   o n l y   f r o n t   f a c e   s t e n c i l   s t a t e   i s   s e t   ( c a s e   5 8 3 2 0 7 ) 
 	 	 c o m p b a c k   e q u a l 
 	 	 c o m p f r o n t   e q u a l 
 	 } 
 
 C G P R O G R A M 
 # p r a g m a   t a r g e t   3 . 0 
 # p r a g m a   v e r t e x   v e r t 
 # p r a g m a   f r a g m e n t   f r a g 
 # p r a g m a   e x c l u d e _ r e n d e r e r s   n o m r t 
 
 s a m p l e r 2 D   _ L i g h t B u f f e r ; 
 s t r u c t   v 2 f   { 
 	 f l o a t 4   v e r t e x   :   S V _ P O S I T I O N ; 
 	 f l o a t 2   t e x c o o r d   :   T E X C O O R D 0 ; 
 } ; 
 
 v 2 f   v e r t   ( f l o a t 4   v e r t e x   :   P O S I T I O N ,   f l o a t 2   t e x c o o r d   :   T E X C O O R D 0 ) 
 { 
 	 v 2 f   o ; 
 	 o . v e r t e x   =   m u l ( U N I T Y _ M A T R I X _ M V P ,   v e r t e x ) ; 
 	 o . t e x c o o r d   =   t e x c o o r d . x y ; 
 	 r e t u r n   o ; 
 } 
 
 f i x e d 4   f r a g   ( v 2 f   i )   :   S V _ T a r g e t 
 { 
 	 r e t u r n   - l o g 2 ( t e x 2 D ( _ L i g h t B u f f e r ,   i . t e x c o o r d ) ) ; 
 } 
 E N D C G   
 } 
 
 } 
 F a l l b a c k   O f f 
 } 
 