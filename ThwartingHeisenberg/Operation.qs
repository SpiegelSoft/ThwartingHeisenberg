namespace Quantum.ThwartingHeisenberg
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

	operation MeasureAllocatedQubitInBasis(numberOfExperiments: Int, basis: Pauli) : Int
	{
		body
		{
			mutable ones = 0;
			using (qubits = Qubit[1])
			{
				for (experiment in 1..numberOfExperiments)
				{
					let qubit = qubits[0];
					let xMeasurement = Measure([PauliX], [qubit]);
					let measurement = Measure([basis], [qubit]);
					if (measurement == Zero) 
					{
						set ones = ones + 1;
					}

					Reset(qubit);
				}
			}

			return ones;
		}
	}

	operation VerifyZEntanglement(numberOfExperiments: Int) : (Int, Int) 
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

					ResetAll(qubits);
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
					let aliceZMeasurement = Measure([PauliZ], [aliceQubit]);
					let bobXMeasurement = Measure([PauliX], [bobQubit]);
					let bobZMeasurement = Measure([PauliZ], [bobQubit]);
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

					ResetAll(qubits);
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
