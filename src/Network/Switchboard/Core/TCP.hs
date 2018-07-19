module Network.Switchboard.Core.TCP where

{-
Whenever we write an application, theres the need to inter-operate
between the
a) state transitions/error model of TCP/the network connection
and
b) the state and error handling of the application

there is a sequence of increasingly rich models to consider
around TCP, regarding hard errors, soft/mixed state errors, and performance

1) Only consider / handle  hard errors and failures in the TCP connection
  a) at one extreme, have you state machine abort the program (prompt but crashy)
  b) retry on failure, which will be a bit less fragile, but will sometimes be
    non responsive for as long as there are connection issues

2) partial errors and their recovery/handling

3) good performance  (throughput/latency/congestion tradeoffs)
  a) at one extreme map every application send to a network send (and its api dual in message receipt)
  b) batch up network sends and receives

other practical issues will naturally also rise to the fore!

1) fairness of message sending (latency/liveness), a sort of scheduling problem
    -> this also requires thinking about chunks/fragmentation of larger bulk transfers
2) often TCP is really TLS, which isn't quite full duplex (unless you've got two TLS streams?)
    2.b)
-}
