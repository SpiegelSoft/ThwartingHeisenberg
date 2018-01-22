namespace Quantum.ThwartingHeisenberg
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

	operation MeasureZ(numberOfExperiments: Int) : (Int, Int) 
	{
		body 
		{
			mutable aliceAndBobZAgreements = 0;
			mutable aliceOnesInZDirection = 0;
			using (qubits = Qubit[2]) 
			{
				for (experiment in 1..numberOfExperiments)
				{
					let aliceQubit = qubits[0];
					let bobQubit = qubits[1];
					PrepareEntangledPair(aliceQubit, bobQubit);
					let aliceZMeasurement = M(aliceQubit);
					let bobZMeasurement = M(bobQubit);
					if (aliceZMeasurement == bobZMeasurement) 
					{
						set aliceAndBobZAgreements = aliceAndBobZAgreements + 1;
					}

					if (aliceZMeasurement == One) 
					{
						set aliceOnesInZDirection = aliceOnesInZDirection + 1;
					}

					Reset(qubits[0]);
					Reset(qubits[1]);
				}
			}

			return (aliceAndBobZAgreements, aliceOnesInZDirection);
		}
	}

	operation MeasureXAndZSimultaneously(numberOfExperiments: Int) : (Int, Int, Int) 
	{
		body 
		{
			mutable aliceAndBobZAgreements = 0;
			mutable aliceOnesInZDirection = 0;
			mutable bobOnesInXDirection = 0;
			using (qubits = Qubit[2]) 
			{
				for (experiment in 1..numberOfExperiments)
				{
					let aliceQubit = qubits[0];
					let bobQubit = qubits[1];
					PrepareEntangledPair(aliceQubit, bobQubit);
					let xBasis = [PauliX];
					let zBasis = [PauliZ];
					let aliceZMeasurement = Measure(zBasis, [aliceQubit]);
					let bobXMeasurement = Measure(xBasis, [bobQubit]);
					let bobZMeasurement = Measure(zBasis, [bobQubit]);
					if (aliceZMeasurement == bobZMeasurement) 
					{
						set aliceAndBobZAgreements = aliceAndBobZAgreements + 1;
					}

					if (aliceZMeasurement == One) 
					{
						set aliceOnesInZDirection = aliceOnesInZDirection + 1;
					}
					
					if (bobXMeasurement == One)
					{
						set bobOnesInXDirection = bobOnesInXDirection + 1;
					}

					Reset(qubits[0]);
					Reset(qubits[1]);
				}
			}

			return (aliceAndBobZAgreements, aliceOnesInZDirection, bobOnesInXDirection);
		}
	}

	operation PrepareEntangledPair(here : Qubit, there : Qubit) : () 
	{
		body 
		{
			H(here);
			CNOT(here, there);
		}
	}
}
