using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.ThwartingHeisenberg
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var sim = new QuantumSimulator())
            {
                // Try initial values
                var (agreements, aliceOnesInZDirection, bobOnesInXDirection) = MeasureXAndZSimultaneously.Run(sim, 10000).Result;
                System.Console.WriteLine(
                    $"Alice (Z) ones = {aliceOnesInZDirection}, Bob (X) ones = {bobOnesInXDirection}, agreements (Z) = {agreements}");
            }
            System.Console.WriteLine("Press any key to continue...");
            System.Console.ReadKey();
        }
    }
}