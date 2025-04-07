# RaisingCartoonCharacters
A very simple fan-made game.

2025, April 2
So grouping now is,
    object that is drawn on the floor, like, vomit,blood,carpet etc..
    takes negative values (shitTrails.lua)

group 0, walls,
group 1, walls, but for characters and other types, excluding camera
group 2, first object that I created I assigned that a value 2 (shit.lua)

Note to self:
  1  Ordering of the functions in each line of codes matters!

  2  2025 April 3 commit:
        if you don't understand how to give new type of objects its collision (rectangular collision)
        think of how
                    self.w, self.h, self.scale --> for drawings - scales with respect to forZoomingIn
                    self.init h, self.init w, self.init scale --> for colliders - functions(should not scale)

                now before instanctiating a rectangle object to act as the collider for the new object, 
                better think carefully how are you going to scale things up and which part of the variable should not scale.

    3. 2025 April 7 :
        I remember now, why I'm having trouble with love.graphics.draw()'s height by setting negative value,
        because the drawing order relies on their main coordinates(points toward players) which sorts them with
        respect to it, hence why love.graphics.draw(-height), must be given negative height, and thats why adding
        collider to it is sometimes confusing,

        for the sortOrder looping through different types of objects, they must have similar names for the
        coordinates that represents them, and that would be just (x,y) not x2 or ax etc.. so thats why I had
        to put up the offset for love.graphics.draw() to draw the sprites(their top sides) closer to the abscissa
         making the base coordinates x,y belows it (their bottom sides instead)

        most of the time I don't have to apply the same rules with other types of objects like UI(user interface)
        because those objects arent being translated (moving one another)/(they arrent affected by sortOrder) that
        their drawing order would need
        proper sorting, its redundant so i just treat it as it is as simple.
            If my future self don't understand,
            See this line is the only thing that exist there (at levelLoader.lua)
 		table.sort(LevelLoader.objects, LevelLoader.SortObjects)

