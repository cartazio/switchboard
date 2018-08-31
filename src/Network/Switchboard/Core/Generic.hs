{-# LANGUAGE GADTs, ExplicitForAll, ScopedTypeVariables, KindSignatures #-}
module Network.Switchboard.Core.Generic where

{-
-}

{- | `ConnectionAllocator i m a b`
contravariant in i and a, covariant in b.  aka `ConnectionAllocator i m`
should probably be some profunctor/semigroupoid/category whenever m is an Applicative and/or Monad

-}
--newtype ConnectionAllocator init m a b = ConnectionAllocator (init -> m (ConnectionHandle m a b))


{-
NOTE: the ghc event data type is a new type'd Int that models a lattice over the three
lowest order bits,
read,write,closed are the events in the first, second and third positions. No event / Nothing is modelled as zero
readEvent = Event 1
writeEvent = Event 2
closedEvent = Event 4

one subtle point that may become an issue later is level vs edge triggering for network processing

in that context, edge triggered for reads corresponds with an event when the data first becomes available
to read. whereas a level trigger corresponds with there being data currently available to read

now, a saner / mathy distinction might be

level == predicate on state of the system

edge == predicate on state changes in the system aka a sort of formal derivative / difference
over states

if we imagine our event loop as a sort of continuous time query on system state,
  where we observe

an edge event is only provided for the first time we "observe" the system state after
the applicable state change.  ()

a level event is provided for every system query that happens "while" the predicate
on system state is true
-}


data ConnectionAllocator :: (* -> * ) -> * -> * -> * where
  ConnAlloc :: forall m sendArg sendResp  receiveArg receiveResponse init .
     (init -> m (ConnectionHandle m (init,sendArg,receiveArg) (sendResp, receiveResponse )))
     -> ConnectionAllocator m (init,sendArg,receiveArg) (sendResp,receiveResponse )
     -- this does make error handleing on connection failure a tad implicit ...
     -- do we want that? Lets revisit later


data ConnectionHandle (m :: * -> * ) a b  where
{-
-}
{-
simplified model
data ConnectionHandle m a b =
  ConnectionHandle { sendCH :: a -> m ()
                  , receiveCH :: m b
                  , closeCH :: m ()
                   }


-}
