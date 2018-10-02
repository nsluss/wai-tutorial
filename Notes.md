# Notes

## Getting a web server running
you will notice that we have changed the implementation for `runApp` in 
[Lib.hs](./src/Lib.hs). The `run` function comes from warp, a haskell web 
server. Warp uses WAI, which stands for Web Application Interface. If you look 
in our [package.yaml](package.yaml), you will see that we have added `wai` and
`warp` as dependencies for our project. The relationship here is that warp 
depends on wai, and uses the types from wai for it's interface. As long as your 
app's type matches wai's 
[Application](http://hackage.haskell.org/package/wai-3.2.1.2/docs/Network-Wai.html#t:Application), 
type synonym, you can run it with warp.

## Testing a WAI app
The fundamental problem in writing unit tests for haskell is isolating `IO`. 
Often this is done by putting functions that produce `IO` behind some kind of 
interface. This can be done with typeclasses in mtl style or with the free 
monad/extensible effect strategy. This isn't nescessary for us yet since at 
this stage the only `IO` we have to do is at the wiring level. While wai's 
`Application` type does include `IO`, we can write a simple adapter to take a 
pure request handler and turn it into something that matches the `Application` 
type. We can treat this adapter as wiring because it will not change any 
behavior and it will do the bare minimum to make the types match. This is one 
place where we can rely on the compiler to verify that our code is doing the 
right thing. This adapter lives in [Types.hs](./src/Types.hs) and is called 
`asApplication`
