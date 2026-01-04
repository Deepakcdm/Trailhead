/**
 * @description       :
 * @author            : Deepak
 * @group             :
 * @last modified on  : 01-04-2026
 * @last modified by  : Deepak
 **/
public with sharing class ApexSandboxSet {
	/**
	 * @description
	 * @author Deepak | 10-20-2024
	 * @param Set<Integer> set1
	 * @param Set<Integer> set2
	 * @return Set<Integer>
	 **/
	public Set<Integer> setUnion(Set<Integer> set1, Set<Integer> set2) {
		//code here
		Set<Integer> set3 = new Set<Integer>();
		set3.addAll(set1);
		set3.addAll(set2);
		return set3;
	}

	/**
	 * @description
	 * @author Deepak | 10-20-2024
	 * @param Set<Integer> set1
	 * @param Set<Integer> set2
	 * @return Set<Integer>
	 **/
	public Set<Integer> setIntersection(Set<Integer> set1, Set<Integer> set2) {
		//code here
		Set<Integer> set3 = new Set<Integer>();
		for (Integer num : set1) {
			if (set2.contains(num)) {
				set3.add(num);
			}
		}
		return set3;
	}

	/**
	 * @description
	 * @author Deepak | 10-20-2024
	 * @param List<Opportunity> opps
	 * @return Set<Id>
	 **/
	public Set<Id> accountIds(List<Opportunity> opps) {
		//code here
		set<Id> accountIds = new Set<Id>();
		for (Opportunity opp : opps) {
			if (opp.AccountId != null) {
				accountIds.add(opp.AccountId);
			}
		}
		return accountIds;
	}

	/**
	 * @description
	 * @author Deepak | 10-20-2024
	 * @param List<Integer> nums1
	 * @param List<Integer> nums2
	 * @return Boolean
	 **/
	public Boolean sameElements(List<Integer> nums1, List<Integer> nums2) {
		//code here
		Set<Integer> num1 = new Set<Integer>(nums1);
		Set<Integer> num2 = new Set<Integer>(nums2);
		Boolean sameElements = num1.containsAll(num2) && num2.containsAll(num1) ? true : false;
		return sameElements;
	}

	/**
	 * @description
	 * @author Deepak | 10-20-2024
	 * @param List<Integer> nums
	 * @return Boolean
	 **/
	public Boolean containsDuplicates(List<Integer> nums) {
		//code here
		Set<Integer> setNums = new Set<Integer>();
		setNums.addAll(nums);
		Boolean containsDuplicates = setNums.size() == nums.size() ? false : true;
		return containsDuplicates;
	}
}