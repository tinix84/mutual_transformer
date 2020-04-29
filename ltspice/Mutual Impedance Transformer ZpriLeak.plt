[AC Analysis]
{
   Npanes: 2
   {
      traces: 1 {2,0,"IM(V(vpri)/(2*PI*Frequency))"}
      X: ('K',0,1000,0,200000)
      Y[0]: ('µ',0,1e-005,2e-006,2e-005)
      Y[1]: ('m',1,-0.001,0.0002,0.001)
      Log: 1 0 0
      GridStyle: 1
      PltReal: 1
      Representation: 2
      Text: "V/Hz" 2 (14142.135623731,1.1965e-005) ;Primary Leakage Inductance, H
   },
   {
      traces: 1 {3,0,"RE(V(vpri))"}
      X: ('K',0,1000,0,200000)
      Y[0]: (' ',1,0.3,0.3,3.3)
      Y[1]: ('m',0,-0.001,0.0002,0.001)
      Log: 1 1 0
      GridStyle: 1
      PltMag: 1
      Text: "" 3 (14142.135623731,1.27241008747153) ;Primary Leakage Resistance
   }
}

