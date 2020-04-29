[AC Analysis]
{
   Npanes: 2
   {
      traces: 1 {2,0,"IM(V(vpri)/(2*PI*Frequency))"}
      X: ('K',1,1000,0,200000)
      Y[0]: ('µ',0,0.00049,1e-005,0.00054)
      Y[1]: ('m',1,-0.001,0.0002,0.001)
      Log: 1 0 0
      GridStyle: 1
      PltReal: 1
      Representation: 2
      Text: "V/Hz" 2 (13696.3703268808,0.0005205) ;Primary Inductance, H
   },
   {
      traces: 1 {3,0,"RE(V(vpri))"}
      X: ('K',1,1000,0,200000)
      Y[0]: ('_',0,0.1,0,100)
      Y[1]: ('m',0,-0.001,0.0002,0.001)
      Log: 1 1 0
      GridStyle: 1
      PltMag: 1
      Text: "V/Hz" 3 (13571.6091859015,5.62341325190349) ;Primary Resistance, Ohm
   }
}

