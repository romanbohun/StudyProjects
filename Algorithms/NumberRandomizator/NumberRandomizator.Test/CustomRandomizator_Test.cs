using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace NumberRandomizator.Test
{
    [TestClass]
    public class CustomRandomizator_Test
    {
        private int _a = 7;
        private int _b = 5;
        private int _m = 11;
        
        [TestMethod]
        public void Initialization_of_randomizator_through_cstor()
        {
            //Prep
            //Act
            var rand = new CustomRandomizator(_a, _b, _m);

            //Assert
            Assert.AreEqual(_a,rand.A);
            Assert.AreEqual(_b, rand.B);
            Assert.AreEqual(_m, rand.M);
        }
        
        [TestMethod]
        public void Initialization_of_randomizator_through_init_method()
        {
            //Prep
            var rand = new CustomRandomizator();
            
            //Act
            rand.Init(_a, _b, _m);

            //Assert
            Assert.AreEqual(_a,rand.A);
            Assert.AreEqual(_b, rand.B);
            Assert.AreEqual(_m, rand.M);
        }

        [TestMethod]
        public void Generate_a_number_with_start_number_0()
        {
            //Prep
            var startNumber = 0;
            var expected = 5;
            var rand = new CustomRandomizator(_a, _b, _m);
            
            //Act
            var result = rand.Generate(startNumber);
            
            //Assert
            Assert.AreEqual(expected, result);
        }

        [TestMethod]
        public void Generate_a_number_with_start_number_7()
        {
            //Prep
            var startNumber = 7;
            var expected = 10;
            var rand = new CustomRandomizator(_a, _b, _m);

            //Act
            var result = rand.Generate(startNumber);

            //Assert
            Assert.AreEqual(expected, result);
        }
        
        [TestMethod]
        public void Generate_a_collection_of_numbers_with_start_number_0_and_capacity_3()
        {
            //Prep
            var startNumber = 0;
            var collectionCapacity = 3;
            var expected = new int[collectionCapacity];
            var rand = new CustomRandomizator(_a, _b, _m);

            //Act
            IEnumerable<int> result = rand.Generate(startNumber, collectionCapacity);

            //Assert
            Assert.AreEqual(expected.Count(), result.Count());
        }
        
        [TestMethod]
        public void Generate_a_collection_of_generated_numbers_with_start_number_0_and_capacity_3()
        {
            //Prep
            var startNumber = 0;
            var collectionCapacity = 3;
            var expected = new [] {5, 7, 10};
            
            var rand = new CustomRandomizator(_a, _b, _m);

            //Act
            IEnumerable<int> result = rand.Generate(startNumber, collectionCapacity);

            //Assert
            Assert.AreEqual(expected.Count(), result.Count());
            
            Assert.AreEqual(expected.ElementAt(0), result.ElementAt(0));
            Assert.AreEqual(expected.ElementAt(1), result.ElementAt(1));
            Assert.AreEqual(expected.ElementAt(2), result.ElementAt(2));
        }
        
        [TestMethod]
        public void Generate_a_collection_of_generated_numbers_with_start_number_0_and_capacity_10()
        {
            //Prep
            var startNumber = 0;
            var collectionCapacity = 10;
            var expected = new[] {5, 7, 10, 9, 2, 8, 6, 3, 4, 0};
            
            var rand = new CustomRandomizator(_a, _b, _m);

            //Act
            IEnumerable<int> result = rand.Generate(startNumber, collectionCapacity);

            //Assert
            Assert.AreEqual(expected.Count(), result.Count());
            
            Assert.AreEqual(expected.ElementAt(0), result.ElementAt(0));
            Assert.AreEqual(expected.ElementAt(1), result.ElementAt(1));
            Assert.AreEqual(expected.ElementAt(2), result.ElementAt(2));
            Assert.AreEqual(expected.ElementAt(3), result.ElementAt(3));
            Assert.AreEqual(expected.ElementAt(4), result.ElementAt(4));
            Assert.AreEqual(expected.ElementAt(5), result.ElementAt(5));
            Assert.AreEqual(expected.ElementAt(6), result.ElementAt(6));
            Assert.AreEqual(expected.ElementAt(7), result.ElementAt(7));
            Assert.AreEqual(expected.ElementAt(8), result.ElementAt(8));
            Assert.AreEqual(expected.ElementAt(9), result.ElementAt(9));
        }
    }
}