[AC Analysis]
{
   Npanes: 2
   {
      traces: 1 {2,0,"IM(V(vsec)/(2*PI*Frequency))"}
      X: ('K',0,1000,0,200000)
      Y[0]: ('µ',0,2e-005,5e-006,4e-005)
      Y[1]: ('m',1,-0.001,0.0002,0.001)
      Log: 1 0 0
      GridStyle: 1
      PltReal: 1
      Representation: 2
      Text: "V/Hz" 2 (14142.135623731,1.1965e-005) ;Secondary Leakage Inductance, H
      Text: "V/Hz" 2 (7075.31612097466,2.903125e-005) ;Secondary Leakage Inductance, H
   },
   {
      traces: 1 {65539,0,"RE(V(vsec))"}
      X: ('K',0,1000,0,200000)
      Y[0]: (' ',1,0.7,0.7,7.7)
      Y[1]: ('m',0,-0.001,0.0002,0.001)
      Log: 1 1 0
      GridStyle: 1
      PltMag: 1
      Text: "V/Hz" 3 (8258.62776028323,2.54593872764908) ;Secondary Leakage Resistance
   }
}

