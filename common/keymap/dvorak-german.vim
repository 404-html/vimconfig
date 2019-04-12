" this is a mixture of the german dvorak type 1 and type 2 layouts
"this appears at the end of the status line
let b:keymap_name="dvorak-german"
"A cursor color for when keymaps are in use.
"highlight lCursor ctermbg=red guibg=red


" äöüß€’„“«»“”–—

" no key for ä, sits under the a -- to the left, where shift is
" make an alternative binding for this

" just use digraph for this for the moment «A:»
" also assigned it to backtick for the moment

" backslash will be the minus sign key
" CARE: it's still the leader key

loadkeymap
b x
B X
c j
C J
d e
D E
e .
E :
f i
F I
g u
G U
h h
H H
i c
I C
j d
J D
k r
K R
l n
L N
; s
: S
' l
\" L
m m
, w
< W
. v
> V
/ #
? '
M M
n b
N B
o t
O T
p z
P Z
q ü
Q Ü
r p
R P
s o
S O
t y
T Y
u g
U G
v k
V K
w ,
W ;
x q
X Q
y f
Y F
z ö
Z Ö
@ "
# §
^ &
& /
* (
( )
) =
- +
_ *
= <
+ >
[ ?
{ ß
] -
} _
| /
` ä
~ Ä
 [
 ]
 {
 }
 |
 @
