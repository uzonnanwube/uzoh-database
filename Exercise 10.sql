*/Healthcare Manangement System: Develop a database system for a healthcare 
facility, including tables for patients, doctors, appointments, and medical
records. write queries to schedule appointments, track patients diagnosis, 
generate a medical reports, analyze patients demographics. */


CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(255),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Address VARCHAR(255),
    ContactNumber VARCHAR(20),
    Email VARCHAR(255)
);
SELECT * from patients



CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR(255),
    Specialization VARCHAR(255),
    ContactNumber VARCHAR(20),
    Email VARCHAR(255)
);
SELECT * from doctors



CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    time_stamp TIMESTAMP
);
SELECT * from patients



CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentID INT,
    Diagnosis VARCHAR(255),
    Medication VARCHAR(255),
    Comments VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(Appointment_ID)
);
SELECT * from medicalrecords



--1. TO SCHEDULE AN APPOINTMENT

SELECT *
FROM appointments
WHERE time_stamp >= CURRENT_TIMESTAMP
  AND time_stamp <= CURRENT_TIMESTAMP + INTERVAL '1 weeks'
ORDER BY time_stamp ASC;



SELECT *
FROM appointments
WHERE appointment_id IN (402, 403, 404);


INSERT INTO appointments (appointment_id, patient_id, doctor_id, time_stamp)
VALUES (404, 204, 05, '2023-10-14 10:45:00');



--2.TRACK PATIENTS DIAGNOSIS

SELECT MedicalRecords.RecordID, MedicalRecords.PatientID, MedicalRecords.Diagnosis, 
 MedicalRecords.DoctorID, Appointments.Time_stamp
FROM MedicalRecords
JOIN Appointments ON MedicalRecords.AppointmentID = AppointmentID
WHERE MedicalRecords.PatientID IN (169, 148, 190)
LIMIT 3;


--3.GENERATE A MEDICAL REPORT

SELECT
    m.recordid,
    p.patientname,
    DATE_PART('year', age(p.dateofbirth)) AS age,
    m.diagnosis,
    m.medication,
    m.comments,
    d.doctorname
FROM medicalrecords m
JOIN patients p ON m.patientid = p.patientid
JOIN doctors d ON m.doctorid = d.doctorid
LIMIT 5;



--4.ANALYZE PATIENTS DEMOGRAPHICS

SELECT
    CASE
        WHEN DATE_PART('year', age(dateofbirth)) < 18 THEN 'Under 18'
        WHEN DATE_PART('year', age(dateofbirth)) >= 18 AND DATE_PART('year', age(dateofbirth)) < 30 THEN '18-29'
        WHEN DATE_PART('year', age(dateofbirth)) >= 30 AND DATE_PART('year', age(dateofbirth)) < 40 THEN '30-39'
        WHEN DATE_PART('year', age(dateofbirth)) >= 40 AND DATE_PART('year', age(dateofbirth)) < 50 THEN '40-49'
        WHEN DATE_PART('year', age(dateofbirth)) >= 50 THEN '50 and above'
        ELSE 'Unknown'
    END AS AgeRange,
    Gender,
    COUNT(*) AS Count
FROM Patients
GROUP BY AgeRange, Gender;


SELECT Gender, COUNT(*) as Count
FROM Patients
GROUP BY Gender;


































 












