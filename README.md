


### 🇬🇧 NHS Hospital Waiting Times Analysis (April – July 2025)

![diverse-group-people-waiting-hospital-reception-lobby-attend-medical-appointment-with-general-practitioner-patients-waiting-room-lobby-sitting-healthcare-clinic-tripod-shot](https://github.com/user-attachments/assets/466b58b2-c3a6-4b49-a18a-fc57444f2323)


**Author:** Mohd Nafees  
🎓 MSc Data Science — Birkbeck, University of London  
📧 [nafees.mohd.datascientist25@gmail.com](mailto:nafees.mohd.datascientist25@gmail.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/mohd-nafees-59863524b/)  
📍 London    🗓 November 2025  

---

## 🧠 Project Overview
Between **April and July 2025**, NHS England managed millions of elective-care referrals under its *Referral to Treatment (RTT)* programme.  
This project builds a **fully automated analytics pipeline** that turns 77 million + rows of raw CSVs into clean, interactive insights.

### 💡 Tools
| Component | Technology Used |
|------------|----------------|
| Data Cleaning & Aggregation | Python (pandas, NumPy, Matplotlib) |
| Data Modelling | SQL Server Management Studio (SSMS 2.0) |
| Visualization | Power BI |
| Dataset Source | NHS England RTT (Open Government Licence v3.0) |

---

## 🎯 Objective
To analyse NHS hospital waiting-time trends (Apr–Jul 2025), identify bottlenecks, and forecast demand — helping NHS leaders allocate capacity and reduce backlogs.

### 📄 Preview Report 
![NHS_report_preview_small](https://github.com/user-attachments/assets/bf6cc6f2-58be-44df-a3a3-79b595494ad6)

## 📈 Power BI Dashboard Previews

### 🎥 Dashboard Demo 

![NHS_preview_small](https://github.com/user-attachments/assets/6273efb1-a9b7-48d9-9a4a-c6de67a6815a)

---

## 📚 Data Source
**Dataset:** NHS England — Referral to Treatment (RTT) Waiting Times for Consultant-Led Elective Care  
**Coverage:** April → July 2025  
**Publisher:** NHS England & Department of Health and Social Care  
**Licence:** [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/)

**Official Downloads**
- [April 2025 RTT Dataset](https://www.gov.uk/government/statistics/referral-to-treatment-waiting-times-statistics-for-consultant-led-elective-care-for-april-2025)  
- [May 2025 RTT Dataset](https://www.gov.uk/government/statistics/referral-to-treatment-waiting-times-statistics-for-consultant-led-elective-care-for-may-2025)  
- [June 2025 RTT Dataset](https://www.gov.uk/government/statistics/referral-to-treatment-waiting-times-statistics-for-consultant-led-elective-care-for-june-2025)  
- [July 2025 RTT Dataset](https://www.england.nhs.uk/statistics/statistical-work-areas/rtt-waiting-times/)

📦 **Total Records:** ≈ 77 million (~ 7 GB raw)

---

## 🧹 Data Preparation (Python)

**Notebook:** `nhs_waiting_Analysis.ipynb`  
**Final Output:** `NHS_waiting_times_cleaned.csv` (7.7 M rows × 4 columns)

### Steps Performed
1. Loaded four monthly CSV files using `glob` and merged them.  
2. Added a `Period` field extracted from file names.  
3. Selected core columns: `Period`, `Provider Org Name`, `WaitBand`, `Patients`.  
4. Transformed wide → long format via `pd.melt`.  
5. Replaced missing `Patients` values with 0 (no patients reported ≠ missing data).  
6. Grouped and classified wait-bands into four categories:  

| Wait Category | Definition |
|---------------|------------|
| 0–18 Weeks | Met NHS target window |
| 18–52 Weeks | Medium delays |
| 52+ Weeks | Long waiters |
| Other | Unclassified / Incomplete data |

**Final shape:** `7.7 M rows × 4 columns`  
**Missing values:** 0  

---

## 📊 Exploratory Analysis (Highlights)

### 🧩 Top Providers by Patient Volume
| Provider | Total Patients |
|-----------|----------------|
| Manchester University NHS Foundation Trust | 2,032,806 |
| Mid and South Essex NHS Foundation Trust | 1,731,802 |
| Royal Free London NHS Foundation Trust | 1,432,694 |
| Northern Care Alliance NHS Foundation Trust | 1,405,700 |
| Barts Health NHS Trust | 1,383,074 |

### ⏱ Patients by Wait Category
- 78 % of classified patients seen within **0–18 weeks**  
- 17.6 % between **18–52 weeks**  
- ≈ 4 % waited > 1 year  
<img width="452" height="162" alt="image" src="https://github.com/user-attachments/assets/b46fc26e-dd51-4373-8188-542b97bd2ffa" />

> Around 78 % of all records fell under “Other,” due to unclassified bands — a key data-quality issue.

### 📈 Trend ( Apr → Jul 2025 )
- Steady increase in total patients  
- Short wait ( 0–18 weeks ) dominates volume  
- Long waits ( > 52 weeks ) stable → throughput resilience  

<img width="452" height="168" alt="image" src="https://github.com/user-attachments/assets/7d1cc7a0-9c50-4f57-96f4-ac056d0c9004" />


---

## 🧾 Aggregation & ETL Rationale

| Challenge | Solution |
|------------|-----------|
| Raw 77 M+ rows (~7 GB) slows SQL & Power BI | Aggregated in Python to 7.7 M records |
| Missing bands mislead totals | Replaced NaN → 0 |
| Multiple WaitBand columns | Melted to long structure |
| Performance for Power BI | Loaded into SQL as views |

✅ **ETL Pipeline Summary**  
1. Extract – RTT CSV files (Apr–Jul 2025)  
2. Transform – Clean + Aggregate in Python  
3. Load – Store to SQL Server for Power BI  

---

## 🧱 SQL Modelling (SSMS 2.0)

**File:** `nhs_waiting_times.sql`

| View | Purpose |
|------|----------|
| `vw_Fact_PatientWaits` | Aggregated patients by Period + Provider + WaitCategory |
| `vw_Dim_Date` | Year, Month, and Formatted Period |
| `vw_Dim_Provider` | Unique Provider List |
| `vw_Dim_WaitCategory` | Standardized Wait Categories |

A simple **star schema** improves Power BI performance and simplifies joins for slicers and filters.  

<img width="452" height="233" alt="image" src="https://github.com/user-attachments/assets/4d9c6848-eda5-4e4f-ad0d-69f855f09a30" />
 

---

### 📊 Dashboard Page
<img width="452" height="251" alt="image" src="https://github.com/user-attachments/assets/c66b7655-bc6c-4ae5-8044-7c5b0ff70b19" />

| **Executive Overview** | National totals & category trends | 20.51 M patients (July 2025 peak) |
<img width="452" height="251" alt="image" src="https://github.com/user-attachments/assets/238f18d4-6f06-40fd-9eef-c37cdddecf64" />

| **Provider Performance** | Top 10 trusts | Manchester & Essex handle 20 % load |
<img width="452" height="251" alt="image" src="https://github.com/user-attachments/assets/54aa7e5d-0d69-4c08-a40c-844307e4f274" />

| **Wait-Time Distribution** | Performance vs target | 78 % ≤ 18 weeks, 4 % > 1 year |
<img width="452" height="250" alt="image" src="https://github.com/user-attachments/assets/2900cb78-7ea9-4be6-ad8e-1dbb1c2b7486" />

| **Forecast (Time Series)** | Predictive insight | Stable through Q3 2025 |

---

## 💡 Key Business Insights & Recommendations

| Insight | Meaning | Recommendation |
|----------|----------|----------------|
| Most patients within 18 weeks | NHS meeting core RTT goals | Maintain efficiency planning |
| 78 % data unclassified | Data gaps at source | Improve digital reporting standards |
| 4 % > 1 year | Small but persistent backlog | Targeted funding for long-waiters |
| High load in few trusts | Regional imbalance | Re-distribute capacity |
| Stable monthly trend | Operational resilience | Continue monitoring |

---

## 📘 Deliverables

/data/NHS_waiting_times_cleaned.csv
/sql/nhs_waiting_times.sql
/reports/NHS_Hospital_Waiting_Times_Analysis.pdf
/notebooks/nhs_waiting_Analysis.ipynb

---

## ⚙️ Run the Project
```bash
git clone https://github.com/Combatant94/nhs-hospital-waiting-analysis-2025.git
cd nhs-hospital-waiting-analysis-2025
pip install -r requirements.txt
jupyter notebook notebooks/nhs_waiting_Analysis.ipynb

Power BI Steps
	1.	Import NHS_waiting_times_cleaned.csv into SQL Server (SSMS 2.0)
	2.	Run nhs_waiting_times.sql to create views
	3.	Connect Power BI → SQL Server → Model → Visualise

⸻

✅ Results Summary
	•	80.99 M total patients analysed (Apr–Jul 2025)
	•	78 % seen ≤ 18 weeks
	•	4 % waited > 52 weeks
	•	July 2025 = peak activity (20.51 M patients)
	•	SQL + Power BI automate NHS performance tracking


