Credit to Bryce Hesterman
from the fb conversation:
I'm starting a new thread on ac resistance of windings as a continuation of what I replied to on Stuart Wood's post.
Here are the references:

This reference explains mutual impedances including mutual resistances. This is the key to understanding ac resistances of windings.

J. H. Spreen, "Electrical terminal representation of conductor loss in transformers," in IEEE

Transactions on Power Electronics, vol. 5, no. 4, pp. 424-429, Oct. 1990.

https://ieeexplore.ieee.org/document/60685

This reference shows one way to model transformers that uses mutual impedances. They even show how to include capacitive effects.

E. E. Mombello and K Moller, "New power transformer model for the calculation of electromagnetic

resonant transient phenomena including frequency-dependent losses"

IEEE TRANSACTIONS ON POWER DELIVERY, VOL. 15, NO. 1, JANUARY 2000, pp. 167-174.

https://ieeexplore.ieee.org/document/847246

Here is a link to a zip file that shows how to model ac resistances for a two-winding transformer based on Mombello's method. The zip file includes a Mathcad file, a pdf of the Mathcad file and LTspice files that demonstrate how to do a circuit model that includes mutual resistances. There are LTspice files that show the open-circuit and leakage (short-circuit) impedances of the primary and secondary windings, and they match the measured data very closely. There is no way that L-R networks on the primary and secondary windings can match both open-circuit and short-circuit ac resistances. The Mombello method is general. It works for any number of windings, integrated magnetics, flyback and multiple-output flyback transformers. http://www.verimod.com/pdf_files/Mutual_Impedance_Transformer_Model_rev_6.zip
