# Pong
Pong Game (LÖVE2D)

Jednoduchá arkádová hra inspirovaná klasikou Pong, vytvořená v Lua pomocí frameworku LÖVE2D.

Gameplay 
2 hráči proti sobě (lokální multiplayer) Ovládání: 
Levý hráč: W / S 
Pravý hráč: ↑ / ↓ 
Míček se postupně zrychluje s každým odrazem 
Náhodně se spawnují překážka, která ovlivňuje trajektorii míčku 
Po vstřelení bodu se hra na chvíli pozastaví a míček se resetuje 

Funkce 
Detekce kolizí s pálkami, stěnami a překážkami 
Dynamické zrychlování hry Systém skóre 
Náhodné generování překážky 

Technické detaily 
Použit delta time (dt) pro plynulý pohyb nezávislý na FPS 
Kolize řešeny pomocí jednoduché AABB logiky 
Objektově orientovaný přístup (Ball, Paddle, Obstacle) 
Oddělení herní logiky (Game) od jednotlivých entit 

Spuštění 
Nainstaluj LÖVE2D: https://love2d.org/

Spusť projekt:

love . 

Struktura projektu
conf.lua – nastavení okna a hry 
main.lua – vstupní bod 
game.lua – hlavní herní logika 
ball.lua – logika míčku 
paddle.lua – logika pálek 
obstacle.lua – překážky

--

Pong Game (LÖVE2D)

A simple arcade game inspired by the classic Pong, created in Lua using the LÖVE2D framework.

Gameplay

2 players against each other (local multiplayer) 
Left player: W / S 
Right player: ↑ / ↓ 
The ball gradually speeds up with each bounce 
Obstacles spawn randomly and affect the ball’s trajectory 
After a point is scored, the game briefly pauses and the ball resets

Features

Collision detection with paddles, walls, and obstacles 
Dynamic speed increase during gameplay 
Score system 
Random obstacle generation

Technical details

Uses delta time (dt) for smooth movement independent of FPS 
Collision handled using simple AABB logic 
Object-oriented approach (Ball, Paddle, Obstacle) 
Game logic separated from individual entities

How to run Install LÖVE2D: https://love2d.org/

Run the project:

love .

Project structure

conf.lua – window and game configuration 
main.lua – entry point 
game.lua – main game logic 
ball.lua – ball behavior 
paddle.lua – paddle logic 
obstacle.lua – obstacles
