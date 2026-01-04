/**
 * @description       :
 * @author            : Deepak
 * @group             :
 * @last modified on  : 01-04-2026
 * @last modified by  : Deepak
 **/
public with sharing class ApexSandboxDataBase {
	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 * @param String name
	 * @param String email
	 * @return Id
	 **/
	public Id insertStudent(String name, String email) {
		// code here
		apxio__Student__c student = new apxio__Student__c(Name = name, apxio__Email__c = email);
		insert student;
		return student.Id;
	}

	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 * @param String name
	 * @param String details
	 * @param Integer credits
	 * @return Id
	 **/
	public Id insertCourse(String name, String details, Integer credits) {
		// code here
		try {
			apxio__Course__c course = new apxio__Course__c(Name = name, apxio__Course_Details__c = details, apxio__Credits__c = string.valueof(credits));
			insert course;
			return course.Id;
		} catch (exception e) {
			return null;
		}
	}

	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 * @param String name
	 * @param String phone
	 * @param String email
	 * @return String
	 **/
	public String registerStudent(String name, String phone, String email) {
		// code here
		apxio__Student__c student = new apxio__Student__c(Name = name, apxio__Phone__c = phone, apxio__Email__c = email);
		insert student;
		String registerNumber = [SELECT apxio__Registration_Number__c FROM apxio__Student__c WHERE Id = :student.Id]?.apxio__Registration_Number__c;
		return registerNumber;
	}

	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 * @return List<apxio__Student__c>
	 **/
	public List<apxio__Student__c> selectActiveStudents() {
		// code here
		return [SELECT Id, Name FROM apxio__Student__c WHERE apxio__Active__c = TRUE AND Name != NULL];
	}

	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 * @return List<apxio__Student__c>
	 **/
	public List<apxio__Student__c> selectUnreachableStudents() {
		// code here
		return [SELECT Id, Name, apxio__Registration_Number__c FROM apxio__Student__c WHERE apxio__Active__c = TRUE AND apxio__Email__c = NULL AND apxio__Phone__c = NULL ORDER BY NAME];
	}

	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 * @return List<apxio__Student__c>
	 **/
	public List<apxio__Student__c> selectStudentsWithoutContactInfo() {
		// code here
		return [SELECT Id, Name, apxio__Registration_Number__c FROM apxio__Student__c WHERE apxio__Active__c = TRUE AND (apxio__Email__c = NULL OR apxio__Phone__c = NULL) ORDER BY NAME];
	}

	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 * @param String name
	 * @param String description
	 **/
	public void createCourseAndClass(String name, String description) {
		// code here
		apxio__Course__c course = new apxio__Course__c(Name = name, apxio__Course_Details__c = description);
		insert course;

		apxio__Class__c classDetail = new apxio__Class__c(apxio__Course__c = course.Id, Name = name, apxio__Description__c = description?.length() > 255 ? description?.left(255) : description);
		insert classDetail;
	}

	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 * @param List<String> studentNames
	 * @param List<String> studentEmails
	 **/
	public void insertStudents(List<String> studentNames, List<String> studentEmails) {
		// code here
		List<apxio__Student__c> students = new List<apxio__Student__c>();
		for (Integer i = 0; i < studentNames.size(); i++) {
			students.add(new apxio__Student__c(Name = studentNames[i], apxio__Email__c = studentEmails[i]));
		}
		insert students;
	}

	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 * @param String courseName
	 * @return Id
	 **/
	public Id classFromCourse(String courseName) {
		// code here
		List<apxio__Course__c> courses = [SELECT Id FROM apxio__Course__c WHERE Name = :courseName LIMIT 1];

		if (!courses.isEmpty()) {
			apxio__Class__c classDetail = new apxio__Class__c(apxio__Course__c = courses[0].Id, Name = courseName);
			insert classDetail;
			return classDetail.Id;
		}
		return null;
	}

	/**
	 * @description
	 * @author Deepak | 11-02-2024
	 * @param List<String> emails
	 * @param String className
	 **/
	public void enrollStudents(List<String> emails, String className) {
		// code here
		apxio__Class__c classDetail = [SELECT Id, Name FROM apxio__Class__c WHERE Name = :className LIMIT 1];
		List<apxio__Student__c> students = [SELECT Id, apxio__Email__c FROM apxio__Student__c WHERE apxio__Email__c IN :emails];

		if (classDetail != null && !students.isEmpty()) {
			List<apxio__Class_Enrollment__c> enrollments = new List<apxio__Class_Enrollment__c>();
			for (apxio__Student__c student : students) {
				if (emails.contains(student.apxio__Email__c)) {
					enrollments.add(new apxio__Class_Enrollment__c(apxio__Student__c = student.Id, apxio__Offered_Class__c = classdetail.Id));
				}
			}
			insert enrollments;
		}
	}
}