FasdUAS 1.101.10   ��   ��    k             l     ��  ��    @ : Copyright 2007-2015 The Omni Group.  All rights reserved.     � 	 	 t   C o p y r i g h t   2 0 0 7 - 2 0 1 5   T h e   O m n i   G r o u p .     A l l   r i g h t s   r e s e r v e d .   
  
 l     ��������  ��  ��        l     ��  ��    � � $Header: svn+ssh://source.omnigroup.com/Source/svn/Omni/trunk/OmniGroup/Applications/OmniFocus/App/Preferences/MailAction.applescript 237336 2015-07-07 20:35:42Z bungi $     �  T   $ H e a d e r :   s v n + s s h : / / s o u r c e . o m n i g r o u p . c o m / S o u r c e / s v n / O m n i / t r u n k / O m n i G r o u p / A p p l i c a t i o n s / O m n i F o c u s / A p p / P r e f e r e n c e s / M a i l A c t i o n . a p p l e s c r i p t   2 3 7 3 3 6   2 0 1 5 - 0 7 - 0 7   2 0 : 3 5 : 4 2 Z   b u n g i   $      l     ��������  ��  ��     ��  w          k             i         I      �� ���� 0 process_message     ��  o      ���� 0 
themessage 
theMessage��  ��    k     X       r        !   n      " # " 1    ��
�� 
subj # o     ���� 0 
themessage 
theMessage ! o      ���� 0 
thesubject 
theSubject   $ % $ r    	 & ' & m    ��
�� boovfals ' o      ���� 0 
singletask 
singleTask %  ( ) ( Z   
 % * +���� * l  
  ,���� , C   
  - . - o   
 ���� 0 
thesubject 
theSubject . m     / / � 0 0 
 F w d :  ��  ��   + k    ! 1 1  2 3 2 l   �� 4 5��   4 0 * Whole forwarded messages shouldn't split.    5 � 6 6 T   W h o l e   f o r w a r d e d   m e s s a g e s   s h o u l d n ' t   s p l i t . 3  7 8 7 r     9 : 9 m    ��
�� boovtrue : o      ���� 0 
singletask 
singleTask 8  ;�� ; r    ! < = < n     > ? > 7  �� @ A
�� 
ctxt @ m    ����  A m    ������ ? o    ���� 0 
thesubject 
theSubject = o      ���� 0 
thesubject 
theSubject��  ��  ��   )  B C B r   & / D E D b   & - F G F b   & + H I H m   & ' J J � K K  m e s s a g e : / / % 3 c I n  ' * L M L 1   ( *��
�� 
meid M o   ' (���� 0 
themessage 
theMessage G m   + , N N � O O  % 3 e E o      ���� 0 
messageurl 
messageURL C  P Q P r   0 = R S R b   0 ; T U T b   0 7 V W V b   0 5 X Y X b   0 3 Z [ Z o   0 1���� 0 
thesubject 
theSubject [ o   1 2��
�� 
ret  Y o   3 4���� 0 
messageurl 
messageURL W o   5 6��
�� 
ret  U n   7 : \ ] \ 1   8 :��
�� 
ctnt ] o   7 8���� 0 
themessage 
theMessage S o      ���� 0 thetext theText Q  ^�� ^ O   > X _ ` _ k   B W a a  b c b r   B O d e d I  B M�� f g
�� .OFOCFCP?null���     docu f 1   B E��
�� 
FCDo g �� h i
�� 
FCFT h o   F G���� 0 thetext theText i �� j��
�� 
FC1T j o   H I���� 0 
singletask 
singleTask��   e o      ���� 0 thetask theTask c  k�� k n  P W l m l I   Q W�� n���� 0 add_attachments_to_task   n  o p o o   Q R���� 0 
themessage 
theMessage p  q�� q o   R S���� 0 thetask theTask��  ��   m  f   P Q��   ` m   > ? r r�                                                                                  OFOC  alis    X  Macintosh HD               �	��H+   �gOmniFocus.app                                                   ��d�eY        ����  	                Applications    �	��      �WI     �g  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  ��     s t s l     ��������  ��  ��   t  u v u i     w x w I      �� y���� 0 add_attachments_to_task   y  z { z o      ���� 0 
themessage 
theMessage {  |�� | o      ���� 0 thetasklist theTaskList��  ��   x k     � } }  ~  ~ w      � � � k     � �  � � � r     � � � n     � � � 4    �� �
�� 
cobj � m    ����  � o    ���� 0 thetasklist theTaskList � o      ���� 0 t   �  ��� � r   	  � � � n   	  � � � 1   
 ��
�� 
ID   � o   	 
���� 0 t   � o      ���� 0 	thetaskid 	theTaskId��   ��                                                                                  OFOC  alis    X  Macintosh HD               �	��H+   �gOmniFocus.app                                                   ��d�eY        ����  	                Applications    �	��      �WI     �g  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��     � � � l   ��������  ��  ��   �  ��� � w    � � � � X    � ��� � � k   # � � �  � � � l  # #��������  ��  ��   �  � � � Q   # � � � � � k   & f � �  � � � O   & 2 � � � r   * 1 � � � l  * / ����� � c   * / � � � n   * - � � � 1   + -��
�� 
pnam � o   * +���� 0 theattachment theAttachment � m   - .��
�� 
TEXT��  ��   � o      ���� $0 myattachmentname MyAttachmentName � m   & ' � ��                                                                                  emal  alis    F  Macintosh HD               �	��H+   �gMail.app                                                        ��	�곤        ����  	                Applications    �	��      �꥔     �g  #Macintosh HD:Applications: Mail.app     M a i l . a p p    M a c i n t o s h   H D  Applications/Mail.app   / ��   �  � � � l  3 3��������  ��  ��   �  � � � l  3 3�� � ���   � d ^ Build a unique name in the temporary items folder (using the task id to help unique the name)    � � � � �   B u i l d   a   u n i q u e   n a m e   i n   t h e   t e m p o r a r y   i t e m s   f o l d e r   ( u s i n g   t h e   t a s k   i d   t o   h e l p   u n i q u e   t h e   n a m e ) �  � � � O   3 W � � � k   7 V � �  � � � r   7 > � � � I  7 <�� ���
�� .earsffdralis        afdr � m   7 8��
�� afdrtemp��   � o      ���� 0 tempdirectory tempDirectory �  � � � r   ? D � � � n   ? B � � � 1   @ B��
�� 
posx � o   ? @���� 0 tempdirectory tempDirectory � o      ���� 00 tempdirectoryposixpath tempDirectoryPosixPath �  � � � r   E P � � � b   E N � � � b   E L � � � b   E J � � � b   E H � � � o   E F���� 00 tempdirectoryposixpath tempDirectoryPosixPath � m   F G � � � � �  / � o   H I���� 0 	thetaskid 	theTaskId � m   J K � � � � �  - � o   L M���� $0 myattachmentname MyAttachmentName � o      ���� 0 tempposixpath tempPosixPath �  ��� � r   Q V � � � c   Q T � � � o   Q R���� 0 tempposixpath tempPosixPath � m   R S��
�� 
furl � o      ���� 0 tempfileurl tempFileURL��   � m   3 4 � ��                                                                                  sevs  alis    �  Macintosh HD               �	��H+   �f�System Events.app                                               �]���A        ����  	                CoreServices    �	��      ��1     �f� �f� �f�  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��   �  � � � l  X X��������  ��  ��   �  ��� � O   X f � � � I  \ e�� � �
�� .coresavenull���     obj  � o   \ ]���� 0 theattachment theAttachment � �� ���
�� 
kfil � o   ` a���� 0 tempfileurl tempFileURL��   � m   X Y � ��                                                                                  emal  alis    F  Macintosh HD               �	��H+   �gMail.app                                                        ��	�곤        ����  	                Applications    �	��      �꥔     �g  #Macintosh HD:Applications: Mail.app     M a i l . a p p    M a c i n t o s h   H D  Applications/Mail.app   / ��  ��   � R      �� � �
�� .ascrerr ****      � **** � o      ���� 0 m   � �� ���
�� 
errn � o      ���� 0 n  ��   � k   n � � �  � � � l  n n�� � ���   � ? 9 Failed the save the attachment, we should just bail here    � � � � r   F a i l e d   t h e   s a v e   t h e   a t t a c h m e n t ,   w e   s h o u l d   j u s t   b a i l   h e r e �  � � � I  n }�� ���
�� .sysodlogaskr        TEXT � b   n y � � � b   n w � � � b   n s � � � m   n q � � � � � R E r r o r   w h e n   s a v i n g   a t t a c h m e n t   f r o m   M a i l :   ( � o   q r���� 0 n   � m   s v � � � � �  )   � o   w x���� 0 m  ��   �  ��� � L   ~ �����  ��   �  � � � l  � ���~�}�  �~  �}   �  � � � Q   � � � � � � O   � � �  � O   � � I  � ��|�{
�| .corecrel****      � null�{   �z
�z 
kocl m   � ��y
�y 
OSfA �x�w
�x 
prdt K   � � �v	
�v 
atfn o   � ��u�u 0 tempfileurl tempFileURL	 �t
�s
�t 
OSin
 m   � ��r
�r boovtrue�s  �w   n   � � 1   � ��q
�q 
FCno o   � ��p�p 0 t    m   � ��                                                                                  OFOC  alis    X  Macintosh HD               �	��H+   �gOmniFocus.app                                                   ��d�eY        ����  	                Applications    �	��      �WI     �g  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��   � R      �o
�o .ascrerr ****      � **** o      �n�n 0 m   �m�l
�m 
errn o      �k�k 0 n  �l   � k   � �  I  � ��j�i
�j .sysodlogaskr        TEXT b   � � b   � � b   � � m   � � � \ E r r o r   w h e n   c r e a t i n g   a t t a c h m e n t   i n   O m n i F o c u s :   ( o   � ��h�h 0 n   m   � � �  )   o   � ��g�g 0 m  �i   �f L   � ��e�e  �f   �  !  l  � ��d�c�b�d  �c  �b  ! "�a" Q   � �#$�`# O  � �%&% I  � ��_'�^
�_ .coredelonull���     obj ' o   � ��]�] 0 tempfileurl tempFileURL�^  & m   � �((�                                                                                  MACS  alis    t  Macintosh HD               �	��H+   �f�
Finder.app                                                      �����~        ����  	                CoreServices    �	��      ��vn     �f� �f� �f�  6Macintosh HD:System: Library: CoreServices: Finder.app   
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  $ R      �\�[�Z
�\ .ascrerr ****      � ****�[  �Z  �`  �a  �� 0 theattachment theAttachment � n    )*) 2   �Y
�Y 
attc* o    �X�X 0 
themessage 
theMessage ��                                                                                  emal  alis    F  Macintosh HD               �	��H+   �gMail.app                                                        ��	�곤        ����  	                Applications    �	��      �꥔     �g  #Macintosh HD:Applications: Mail.app     M a i l . a p p    M a c i n t o s h   H D  Applications/Mail.app   / ��  ��   v +,+ l     �W�V�U�W  �V  �U  , -�T- i    ./. I     �S0�R
�S .emalcpmanull���     ****0 o      �Q�Q 0 themessages theMessages�R  / Q     61231 k    #44 565 r    
787 I   �P9�O
�P .corecnte****       ****9 o    �N�N 0 themessages theMessages�O  8 o      �M�M "0 themessagecount theMessageCount6 :�L: Y    #;�K<=�J; n   >?> I    �I@�H�I 0 process_message  @ A�GA n    BCB 4    �FD
�F 
cobjD o    �E�E "0 themessageindex theMessageIndexC o    �D�D 0 themessages theMessages�G  �H  ?  f    �K "0 themessageindex theMessageIndex< m    �C�C = o    �B�B "0 themessagecount theMessageCount�J  �L  2 R      �AEF
�A .ascrerr ****      � ****E o      �@�@ 0 m  F �?G�>
�? 
errnG o      �=�= 0 n  �>  3 I  + 6�<H�;
�< .sysodlogaskr        TEXTH b   + 2IJI b   + 0KLK b   + .MNM m   + ,OO �PP 6 E x c e p t i o n   i n   M a i l   a c t i o n :   (N o   , -�:�: 0 n  L m   . /QQ �RR  )  J o   0 1�9�9 0 m  �;  �T   �                                                                                  emal  alis    F  Macintosh HD               �	��H+   �gMail.app                                                        ��	�곤        ����  	                Applications    �	��      �꥔     �g  #Macintosh HD:Applications: Mail.app     M a i l . a p p    M a c i n t o s h   H D  Applications/Mail.app   / ��  ��       �8STUV�8  S �7�6�5�7 0 process_message  �6 0 add_attachments_to_task  
�5 .emalcpmanull���     ****T �4 �3�2WX�1�4 0 process_message  �3 �0Y�0 Y  �/�/ 0 
themessage 
theMessage�2  W �.�-�,�+�*�)�. 0 
themessage 
theMessage�- 0 
thesubject 
theSubject�, 0 
singletask 
singleTask�+ 0 
messageurl 
messageURL�* 0 thetext theText�) 0 thetask theTaskX �( /�'�& J�% N�$�# r�"�!� ���
�( 
subj
�' 
ctxt�& 
�% 
meid
�$ 
ret 
�# 
ctnt
�" 
FCDo
�! 
FCFT
�  
FC1T� 
� .OFOCFCP?null���     docu� 0 add_attachments_to_task  �1 Y��,E�OfE�O�� eE�O�[�\[Z�\Zi2E�Y hO��,%�%E�O��%�%�%��,%E�O� *�,��� E�O)��l+ UU � x��Z[�� 0 add_attachments_to_task  � �\� \  ��� 0 
themessage 
theMessage� 0 thetasklist theTaskList�  Z ������������
� 0 
themessage 
theMessage� 0 thetasklist theTaskList� 0 t  � 0 	thetaskid 	theTaskId� 0 theattachment theAttachment� $0 myattachmentname MyAttachmentName� 0 tempdirectory tempDirectory� 00 tempdirectoryposixpath tempDirectoryPosixPath� 0 tempposixpath tempPosixPath� 0 tempfileurl tempFileURL� 0 m  �
 0 n  [ $ ��	� ������ ����  � ���������] � �����������������(������
�	 
cobj
� 
ID  
� 
attc
� 
kocl
� .corecnte****       ****
� 
pnam
� 
TEXT
� afdrtemp
� .earsffdralis        afdr
�  
posx
�� 
furl
�� 
kfil
�� .coresavenull���     obj �� 0 m  ] ������
�� 
errn�� 0 n  ��  
�� .sysodlogaskr        TEXT
�� 
FCno
�� 
OSfA
�� 
prdt
�� 
atfn
�� 
OSin�� 
�� .corecrel****      � null
�� .coredelonull���     obj ��  ��  � ��Z��k/E�O��,E�O�Z Ҡ�-[��l kh  E� 	��,�&E�UO� !�j E�O��,E�O��%�%�%�%E�O��&E�UO� �a �l UW X  a �%a %�%j OhO -� %�a , *�a a a �a ea a  UUW X  a �%a %�%j OhO a   �j !UW X " #h[OY�>V ��/����^_��
�� .emalcpmanull���     ****�� 0 themessages theMessages��  ^ ������������ 0 themessages theMessages�� "0 themessagecount theMessageCount�� "0 themessageindex theMessageIndex�� 0 m  �� 0 n  _ ��������`OQ��
�� .corecnte****       ****
�� 
cobj�� 0 process_message  �� 0 m  ` ������
�� 
errn�� 0 n  ��  
�� .sysodlogaskr        TEXT�� 7 %�j  E�O k�kh )��/k+ [OY��W X  �%�%�%j ascr  ��ޭ