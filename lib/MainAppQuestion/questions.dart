import 'package:flutter/material.dart';



class Questions{


 // ===== Other Starts ===== //

 static List categoryFinish=[0,0,0,0,0,0,0,0];
 static List categoryImageChange=[1,0,0,0,0,0,0,0];
 static String categoryName = "Income";
 static String categoryImage = "images/income.png";
 static int yearfirstTime = 0;
 static bool afterAllCategoryFinish = false;

 // ====== Other Ends ====== //




 // ========= Living Situation Flow work Start ========//
 static int singleQuestionsNo = 1;
 static List answerShow=[];
 static double animatedContainer;
 static int LivingCheck = 0;
 static int livcolContainer = 0;

 //List Singlequestions = ["What is your official marital status in Germany?","What were your occupation in 2019?"];

  void addAnswer(String UserIdentity, String details,String question,List answer,double containerheight)
  {
   print(question);
   print("identity is:"+UserIdentity);
   answerShow.add({"identity":UserIdentity,"details":details,"question":question,"answer":answer,"containerheight":containerheight});

   print(answerShow.toString());


  }

  

  void updateAnswer(String UserIdentity, String details,String question,List answer,double containerheight)
  {
   print("update answer");
   answerShow.insert(0,{"identity":UserIdentity,"details":details,"question":question,"answer":answer,"containerheight":containerheight});
  }


// ========= Living Situation Flow work End ========//



// ========= Income Flow work Start ========//

 static List incomeAnswerShow=[];
 static double incomeAnimatedContainer;
 static String incomeYouIdentity = "you";
 static String incomeYourIdentity = "your";
 static int domainLength = 0;
 static int totalDomain = 0;
 static String serviceName = "";
 static String singleValuableName = "";
 static int valuableLength = 0;
 static int totalValuable = 0;
 static String residence = "";


 void IncomeAddAnswer(String UserIdentity, String details,String completequestion,String question,List answer,double containerheight)
 {
  print(question);
  print("identity is:"+UserIdentity);
  incomeAnswerShow.add({"identity":UserIdentity,"details":details,"completequestion":completequestion,"question":question,"answer":answer,"containerheight":containerheight});

  print(incomeAnswerShow.toString());
 }


// ========= Income Flow work End ========//

// ========= Home Flow work Start ========//
static List homeAnswerShow=[];
static double homeAnimatedContainer;
static String homeYouIdentity = "you";
static String homeYourIdentity = "your";
static int utilityBillLength = 0;
static int totalUtilityBill = 0;
static int WEGLength = 0;
static int totalWEG = 0;
static String modeOfTransport = "";
static String Appliance = "";
static String otherFixture = "";
static int secondHouseHoldLength = 0;
static int totalSecondHouseHold = 0;
static String secondHouseHoldText = "";
static int relocationLength = 0;
static int totalRelocation = 0;
static String relocationText = "";
static int craftsmenLength = 0;
static int totalCraftsmen = 0;
static String craftsmenText = "";

  void HomeAddAnswer(String UserIdentity, String details,String completequestion,String question,List answer,double containerheight)
  {
    print(question);
    print("identity is:"+UserIdentity);
    homeAnswerShow.add({"identity":UserIdentity,"details":details,"completequestion":completequestion,"question":question,"answer":answer,"containerheight":containerheight});

    print(homeAnswerShow.toString());
  }


// ========= Home Flow work End ========//


// ========= Work Flow Start ========== //
static List workAnswerShow=[];
static double workAnimatedContainer;
static String workYouIdentity = "you";
static String workYourIdentity = "your";
static int homeOfficeLength = 0;
static int totalHomeOffice = 0;
static String homeOfficeText = "";
static int workFurnitureLength = 0;
static int totalWorkFurniture = 0;
static String workFurnitureText = "";
static String otherFurniture = "";
static bool homeOfficeFurniture = false;
static int workBusTripLength = 0;
static int totalWorkBusTrip = 0;
static String workBusTripText = "";
static int workBusCostLength = 0;
static int totalWorkBusCost = 0;
static String workBusCostText = "";
static int officeFurnitureLength = 0;
static int totalOfficeFurniture = 0;
static String officeFurnitureText = "";
static String otherOfficeFurniture = "";
static int otherItemsLength = 0;
static int totalOtherItems = 0;
static String otherItemsText = "";
static String otherItems ="";
static double applicationExpense;
static int jobInterviewLength = 0;
static int totalJobInterview = 0;
static String jobInterviewText = "";
static String otherCostExpense = "";

 void WorkAddAnswer(String UserIdentity, String details,String completequestion,String question,List answer,double containerheight)
 {
  print(question);
  print("identity is:"+UserIdentity);
  workAnswerShow.add({"identity":UserIdentity,"details":details,"completequestion":completequestion,"question":question,"answer":answer,"containerheight":containerheight});

  print(workAnswerShow.toString());
 }


// ========= Work Flow End ============ //



//Education Flow Start

static List educationAnswerShow=[];
static double educationAnimatedContainer;
static String educationYouIdentity = "you";
static String educationYourIdentity = "your";
static int trainingLength = 1;
static int totalTraining = 0;
static String trainingText = "TRAINING ${trainingLength}";
static String educationOtherCosts = "";
static int schoolRouteLength = 0;
static int totalSchoolRoute = 0;
static String schoolRouteText = "";
static int libraryRouteLength = 0;
static int totalLibraryRoute = 0;
static String libraryRouteText = "";
static int learningRouteLength = 0;
static int totalLearningRoute = 0;
static String learningRouteText = "";
static int unpaidInternLength = 0;
static int totalUnpaidIntern = 0;
static String unpaidInternText = "";
static int excursionLength = 0;
static int totalExcursion = 0;
static String excursionText = "";
static int semesterLength = 0;
static int totalSemester = 0;
static String semesterText = "";
static String educationTraItem = "";
static int expFurnitureLength = 0;
static int totalExpFurniture = 0;
static String educationExpfurniture = "EXPENSIVE FURNITURE";
static String educationOtherFurniture = "";
static int equipmentLength = 0;
static int totalEquipment = 0;
static String equipmentText = "";
static String equipmentName = "";



 void EducationAddAnswer(String UserIdentity, String details,String completequestion,String question,List answer,double containerheight)
 {
  print(question);
  print("identity is:"+UserIdentity);
  educationAnswerShow.add({"identity":UserIdentity,"details":details,"completequestion":completequestion,"question":question,"answer":answer,"containerheight":containerheight});

  print(educationAnswerShow.toString());
 }

 //Education Flow End



// ========= Family Flow Start ========== //

static List familyAnswerShow=[];
static double familyAnimatedContainer;
static String familyYouIdentity = "you";
static String familyYourIdentity = "your";
static int childLength = 0;
static int totalChild = 0;
static String childText = "";
static String childFirstName = "";
static String childrenLive = "";
static String childrenExpense = "";
static int childAddressLength = 0;
static int totalChildAddress = 0;
static String childAddressText = "";
static int kindergartenLength = 0;
static int totalKindergarten = 0;
static String kindergartenText = "";
static int childMinderLength = 0;
static int totalChildMinder = 0;
static String childMinderText = "";
static int nannyLength = 0;
static int totalNanny = 0;
static String nannyText = "";
static int babySitterLength = 0;
static int totalBabySitter = 0;
static String babySitterText = "";
static int aupairLength = 0;
static int totalAupair = 0;
static String aupairText = "";
static int dayCareLength = 0;
static int totalDayCare = 0;
static String dayCareText = "";
static int schoolLength = 0;
static int totalSchool = 0;
static String schoolText = "";




 void FamilyAddAnswer(String UserIdentity, String details,String completequestion,String question,List answer,double containerheight)
 {
  print(question);
  print("identity is:"+UserIdentity);
  familyAnswerShow.add({"identity":UserIdentity,"details":details,"completequestion":completequestion,"question":question,"answer":answer,"containerheight":containerheight});

  print(familyAnswerShow.toString());
 }


// ========= Family Flow End ============ //




// ========= Health Flow Start ========== //

static List healthAnswerShow=[];
static double healthAnimatedContainer;
static String healthYouIdentity = "you";
static String healthYourIdentity = "your";
static int healthChildrenLength = 0;
static int totalHealthChildren = 0;
static String healthChildrenText = "";
static int peopleCareLength = 0;
static int totalPeopleCare = 0;
static String peopleCareText = "";
static int doctorTripLength = 0;
static int totalDoctorTrip = 0;
static String doctorTripText = "";


 void HealthAddAnswer(String UserIdentity, String details,String completequestion,String question,List answer,double containerheight)
 {
  print(question);
  print("identity is:"+UserIdentity);
  healthAnswerShow.add({"identity":UserIdentity,"details":details,"completequestion":completequestion,"question":question,"answer":answer,"containerheight":containerheight});

  print(healthAnswerShow.toString());
 }


// ========= Health Flow End ============ //




// ========= Finance Flow Start ========= //

static List financeAnswerShow=[];
static double financeAnimatedContainer;
static String financeYouIdentity = "you";
static String financeYourIdentity = "your";
static int financeOrganizationLength = 0;
static int totalFinanceOrganization = 0;
static String financeOrganizationText = "";
static int financeEuOrganizationLength = 0;
static int totalFinanceEuOrganization = 0;
static String financeEuOrganizationText = "";
static int financeReligiousLength = 0;
static int totalFinanceReligious = 0;
static String financeReligiousText = "";
static int financePartyLength = 0;
static int totalFinanceParty = 0;
static String financePartyText = "";
static int financeVoterLength = 0;
static int totalFinanceVoter = 0;
static String financeVoterText = "";
static int financeProjectLength = 0;
static int totalFinanceProject = 0;
static String financeProjectText = "";



 void FinanceAddAnswer(String UserIdentity, String details,String completequestion,String question,List answer,double containerheight)
 {
  print(question);
  print("identity is:"+UserIdentity);
  financeAnswerShow.add({"identity":UserIdentity,"details":details,"completequestion":completequestion,"question":question,"answer":answer,"containerheight":containerheight});

  print(financeAnswerShow.toString());
 }


// ========= Finance Flow End ========= //


// ===== Relations Start ======= //

static String haveDisabilityHealth = "";
static String alimonyPaidFamily = "";
static String alimonyFamily = "";
static String alimonyReceivedIncome = "";  //Alimony received
static String alimonyIncomePayment = "";
static String typeAlimonyPay = "";
static String salePropertyIncome = "";   //Sale of property
static String occupationStudyingFinance =""; //Studying
static String childrenYesHealth = ""; // Childrenyes
static String occupationMiniJobHome = "";  // Minijob
static String occupationMiniJobFinance = "";  // Minijob
static String specialistActivityFinance = "";
static String educationCategoryEnable = "";
static String workCategoryEnable = "";
static String familyCategoryEnable = "";






// ===== Relations End ======= //


// ====== Partner Start ====== //

static bool incomePartner = true;
static bool educationPartner = true;
static bool healthPartner = true;
static bool healthYouPartner = true;
static bool financePartner = true;
static bool homePartner = true;
static bool homeSecondHouseholdYou = false; //(Not repeated)
static bool homeSecondHouseholdPartner = false; //(Not repeated)
static bool workPartner = true;
static bool workPartnerSingleMove = false; //(Not Repeated)
static bool workPartnerSingleMoveCal = false; //(Not Repeated)
static String workFirst = ""; //(Not Repeated)

static bool familyPartner = true;
static String familyFirst = "";
static bool familyYou = true;
static bool familyPartnerSingleMove = false;
static bool familyPartnerYouSingleMove = false;
static bool familyPartnerYouSecondMove = false;
static bool familyPartnerEndSingleMove = false;
static bool familyPartnerEndSecondMove = false;

// ====== Partner End ======= //

}