/**
 * @description       :
 * @author            : Deepak
 * @group             :
 * @last modified on  : 01-04-2026
 * @last modified by  : Deepak
 **/
public with sharing class ApexSandboxList {
	/**
	 * @description
	 * @author Deepak | 10-27-2024
	 * @param List<String> accountNames
	 * @return List<String>
	 **/
	public List<String> getNamesInAscOrder(List<String> accountNames) {
		//code here
		accountNames?.sort();
		return accountNames;
	}

	/**
	 * @description
	 * @author Deepak | 10-27-2024
	 * @param List<Integer> numbers
	 * @return Integer
	 **/
	public static Integer arraySum(List<Integer> numbers) {
		//code here
		Integer arraySum = 0;
		if (!numbers.isEmpty()) {
			for (integer i = 0; i < numbers.size(); i++) {
				arraySum += numbers[i];
			}
		}
		return arraySum;
	}

	/**
	 * @description
	 * @author Deepak | 10-27-2024
	 * @param List<Integer> nums
	 * @param Integer target
	 * @return Integer
	 **/
	public Integer findTargetCount(List<Integer> nums, Integer target) {
		// code here
		Integer findTargetCount = 0;
		if (!nums.isEmpty() && target != null) {
			for (integer i = 0; i < nums.size(); i++) {
				if (nums[i] == target) {
					findTargetCount++;
				}
			}
		}
		return findTargetCount;
	}

	/**
	 * @description
	 * @author Deepak | 10-27-2024
	 * @param List<Integer> nums
	 * @param Integer target
	 * @return Integer
	 **/
	public static Integer findLast(List<Integer> nums, Integer target) {
		// code here
		Integer findLast = -1;
		if (!nums.isEmpty() && target != null) {
			for (integer i = 0; i < nums.size(); i++) {
				if (nums[i] == target) {
					findLast = i;
				}
			}
		}
		return findLast;
	}

	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 * @param Integer n
	 * @return List<Integer>
	 **/
	public List<Integer> evenNumbers(Integer n) {
		//code here
		List<Integer> evenNumbers = new List<Integer>();
		integer j = 0;
		for (Integer i = 0; i < n; i++) {
			evenNumbers.add(j += 2);
		}
		return evenNumbers;
	}

	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 * @param List<Integer> nums
	 * @return Integer
	 **/
	public static Integer findLargest(List<Integer> nums) {
		//code here
		Integer findLargest = nums[0];
		if (!nums.isEmpty()) {
			for (integer i = 1; i < nums.size(); i++) {
				findLargest = nums[i] > findLargest ? nums[i] : findLargest;
			}
		}
		return findLargest;
	}

	/**
	 * @description
	 * @author Deepak | 10-25-2024
	 * @param List<Integer> numbers
	 * @return List<Integer>
	 **/
	public List<Integer> positiveIntegers(List<Integer> numbers) {
		//code here
		List<Integer> positiveIntegers = new List<Integer>();
		if (!numbers.isEmpty()) {
			for (Integer num : numbers) {
				if (num > 0) {
					positiveIntegers.add(num);
				}
			}
		}
		return positiveIntegers;
	}

	/**
	 * @description
	 * @author Deepak | 10-25-2024
	 * @param String cityName
	 * @param List<String> cities
	 **/
	public static void insertAtStart(String cityName, List<String> cities) {
		//code here
		if (cities.isEmpty()) {
			cities.add(cityName);
		} else {
			cities.add(0, cityName);
		}
	}

	/**
	 * @description
	 * @author Deepak | 10-25-2024
	 * @param List<String> firstNames
	 * @param List<String> lastNames
	 * @return List<String>
	 **/
	public List<String> fullNames(List<String> firstNames, List<String> lastNames) {
		//code here
		List<String> fullNames = new List<String>();
		for (integer i = 0; i < firstNames.size(); i++) {
			fullNames.add(firstNames[i] + ' ' + lastNames[i]);
		}
		return fullNames;
	}

	/**
	 * @description
	 * @author Deepak | 11-16-2024
	 * @param List<String> adjectives
	 * @param List<String> animals
	 * @return List<String>
	 **/
	public List<String> orgNames(List<String> adjectives, List<String> animals) {
		//code here
		List<String> orgNames = new List<String>();
		for (integer i = 0; i < adjectives.size(); i++) {
			for (integer j = 0; j < animals.size(); j++) {
				orgNames.add(adjectives[i] + '-' + animals[j]);
			}
		}
		return orgNames;
	}

	/**
	 * @description
	 * @author Deepak | 11-17-2024
	 * @param List<Decimal> numbers
	 * @return Decimal
	 **/
	public Decimal average(List<Decimal> numbers) {
		// your code here
		Decimal average;
		Decimal sum = 0;
		for (integer i = 0; i < numbers.size(); i++) {
			sum += numbers[i];
		}
		average = sum / numbers.size();
		return average.setScale(2);
	}

	/**
	 * @description
	 * @author Deepak | 11-17-2024
	 * @param List<Integer> numbers
	 * @return Integer
	 **/
	public static Integer secondLargest(List<Integer> numbers) {
		//code here
		List<Integer> filteredNumbers = new List<Integer>();
		Integer largest = findLargest(numbers);

		for (integer j = 0; j < numbers.size(); j++) {
			if (numbers[j] != largest) {
				filteredNumbers.add(numbers[j]);
			}
		}

		Integer secondLargest = findLargest(filteredNumbers);
		return secondLargest;
	}
}