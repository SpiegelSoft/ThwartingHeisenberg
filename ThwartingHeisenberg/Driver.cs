using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using System;

namespace Quantum.ThwartingHeisenberg
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var sim = new QuantumSimulator())
            {
                MeasureAllocatedQubit(sim, Pauli.PauliX);
                //AttemptToMeasureXAndZSimultaneously(sim);
            }

            Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }

        private static void MeasureAllocatedQubit(QuantumSimulator sim, Pauli basis)
        {
            const int experiments = 10000;
            var zeroes = MeasureAllocatedQubitInBasis.Run(sim, experiments, basis).Result;
            Console.WriteLine($"Basis = {basis}, experiments = {experiments}, zeroes = {zeroes}");
        }

        private static void AttemptToMeasureXAndZSimultaneously(QuantumSimulator sim)
        {
            var (agreements, aliceOnesInZDirection, bobOnesInXDirection) = MeasureXAndZSimultaneously.Run(sim, 10000).Result;
            Console.WriteLine($"Alice (Z) ones = {aliceOnesInZDirection}, Bob (X) ones = {bobOnesInXDirection}, agreements (Z) = {agreements}");
        }
    }
}