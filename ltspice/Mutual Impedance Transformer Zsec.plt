[AC Analysis]
{
   Npanes: 2
   {
      traces: 1 {2,0,"IM(V(vsec)/(2*PI*Frequency))"}
      X: ('K',1,1000,0,200000)
      Y[0]: ('m',2,0.00109,1e-005,0.00121)
      Y[1]: ('m',1,-0.001,0.0002,0.001)
      Log: 1 0 0
      GridStyle: 1
      PltReal: 1
      Representation: 2
      Text: "V/Hz" 2 (13696.3703268808,0.0005205) ;Primary Inductance, H
      Text: "V/Hz" 2 (14014.2665986279,0.0011556157635468) ;Secondary Inductance, H
   },
   {
      traces: 1 {3,0,"RE(V(vsec))"}
      X: ('K',1,1000,0,200000)
      Y[0]: ('_',0,0.1,0,100)
      Y[1]: ('m',0,-0.001,0.0002,0.001)
      Log: 1 1 0
      GridStyle: 1
      PltMag: 1
      Text: "V/Hz" 3 (14078.3830612456,28.6138095609175) ;Secondary Resistance, Ohm
   }
}
