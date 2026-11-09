# 2.5D-Player-System-Godot


## Nodes
 -- Player (CharacterBody3D)  
   | CollisionShape3D ***Physical character***  
   | AnimatedSprite3D ***Visual character***  

## Import Settings (fix pixel art)
 -- Compress   
   | Mode = Lossless  
 -- Mipmaps  
   | Generate = Off  

## AnimatedSprite3D
-- Flags  
   | Billboard = Enabled ***keeps sprite always facing camera***  
   | Texture Filte = Nearest ***stops pixel art from blurring***  
 -- Pixel Size = 0.05  

 ## CollisionShape3D
 -- Shape = CapsuleShape3D  
 -- Size = match AnimatedSprite3D height (Pixel Size × frame height in px)  

 ## Input Map
 -- move_left  
 -- move_right  
 -- move_up  
 -- move_down  
 -- jump  

