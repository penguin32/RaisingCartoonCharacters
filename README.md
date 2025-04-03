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
