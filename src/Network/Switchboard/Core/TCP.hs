module Network.Switchboard.Core.TCP where

{-
-}

{- | `ConnectionAllocator i m a b`
contravariant in i and a, covariant in b.  aka `ConnectionAllocator i m`
should probably be some profunctor/semigroupoid/category whenever m is an Applicative and/or Monad

-}
newtype ConnectionAllocator init m a b = ConnectionAllocator (init -> m (ConnectionHandle m a b))


data ConnectionHandle m a b = ConnectionHandle { sendCH :: a -> m (), receiveCH :: m b  }

