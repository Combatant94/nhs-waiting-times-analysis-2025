### 🇬🇧 NHS Hospital Waiting Times Analysis (April – July 2025)

![diverse-group-people-waiting-hospital-reception-lobby-attend-medical-appointment-with-general-practitioner-patients-waiting-room-lobby-sitting-healthcare-clinic-tripod-shot](https://github.com/user-attachments/assets/466b58b2-c3a6-4b49-a18a-fc57444f2323)

**Author:** Mohd Nafees  
🎓 MSc Data Science — Birkbeck, University of London  
📧 [nafees.mohd.datascientist25@gmail.com](mailto:nafees.mohd.datascientist25@gmail.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/mohd-nafees-59863524b/)  
📍 London    🗓 November 2025  
   
---

🖥️ **[Live interactive dashboard](https://combatant94.github.io/nhs-waiting-times-analysis-2025/dashboard/)** — explore all 477 providers, sort by volume or by long-wait / unclassified-data share

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
**Final Output:** `NHS_waiting_times_cleaned.csv` — 7,544 rows × 4 columns (Period, Provider, WaitCategory, Patients), summarising 80.99M total patient-records

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

**Final shape:** `7,544 rows × 4 columns` (aggregated from 80.99M patient-records)  
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

### Patients by Wait Category

	- 77.8% of records fell under "Other" — traced this to my own wait-band categorization rule, which only matched 12 of the 104 actual band labels (e.g. it caught "Gt 00 To 01 Weeks" but missed "Gt 03 To 04 Weeks"). Caught through validating the rule against every label, before trusting the breakdown.
	- 17.6% confirmed 0–18 weeks
	- 4.2% confirmed 18–52 weeks
	- 0.4% confirmed 52+ weeks

<img width="452" height="162" alt="image" src="https://github.com/user-attachments/assets/b46fc26e-dd51-4373-8188-542b97bd2ffa" />

> 77.8% of records fell under "Other" — not an NHS data-quality issue, but a gap in my own band-matching logic, found by validating it against all 104 actual wait-band labels rather than trusting the output at face value. A reminder to check a categorisation rule's coverage before reporting from it.

### 📈 Trend ( Apr → Jul 2025 )
- Steady increase in total patients  
- Short wait ( 0–18 weeks ) dominates volume  
- Long waits ( > 52 weeks ) stable → throughput resilience  

<img width="452" height="168" alt="image" src="https://github.com/user-attachments/assets/7d1cc7a0-9c50-4f57-96f4-ac056d0c9004" />

---

## 🧾 Aggregation & ETL Rationale

| Challenge | Solution |
|------------|-----------|
| Raw 77 M+ rows (~7 GB) slows SQL & Power BI | Aggregated in Python to 7,544 summary rows |
| Missing bands mislead totals | Replaced NaN → 0 |
| Multiple WaitBand columns | Melted to long structure |
| Performance for Power BI | Loaded into SQL as views |

✅ **ETL Pipeline Summary**  
1. Extract – RTT CSV files (Apr–Jul 2025)  
2. Transform – Clean + Aggregate in Python  
3. Load – Store to SQL Server for Power BI  

---

## 🧱 SQL Modelling (SSMS 2.0)

**File:** `nhs_waiting_time.sql`

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

| **Executive Overview** | National totals & category trends | 20.51 M patients (July 2025 peak) |
<img width="817" height="458" alt="Screenshot 2026-02-17 at 14 14 34" src="https://github.com/user-attachments/assets/b0ef25d7-604a-44be-8ec6-58b98ddca891" />

| **Provider Performance** | Top 10 trusts | Manchester & Essex handle 20 % load |
<img width="817" height="459" alt="Screenshot 2026-02-17 at 14 18 37" src="https://github.com/user-attachments/assets/d07f35d1-31bc-4c85-929c-d2eed0066160" />

| **Wait-Time Distribution** | Performance vs target | 77.8% unclassified ("Other"), 17.6% ≤ 18 weeks, 0.4% waited 52+ weeks |

<img width="816" height="458" alt="Screenshot 2026-02-17 at 14 19 27" src="https://github.com/user-attachments/assets/5225306c-8868-4ca1-8828-97a70c567f0d" />

| **Forecast (Time Series)** | Predictive insight | Stable through Q3 2025 |

<img width="813" height="456" alt="Screenshot 2026-02-17 at 14 20 11" src="https://github.com/user-attachments/assets/046ad24e-cf93-4298-8c8f-4050fab5bbfc" />

---

## 💡 Key Business Insights & Recommendations

| Insight | Meaning | Recommendation |
|----------|----------|----------------|
| Only 17.6% confirmed within 18 weeks | The rest aren't mis-performing — they're simply uncategorised by my rule | Fix the categorisation logic before reporting against RTT targets |
| 77.8% of records unclassified ("Other") | My own band-matching rule only covered 12 of 104 real wait-band labels | Rewrite the rule as a proper numeric-range check, not substring matching |
| 0.4% waited 52+ weeks | Small but persistent backlog | Targeted funding for long-waiters |
| High load in few trusts | Regional imbalance | Re-distribute capacity |
| Stable monthly trend | Operational resilience | Continue monitoring |

---

## 📘 Deliverables

NHS_waiting_times_cleaned.csv
nhs_waiting_time.sql
NHS Hospital Waiting Times Analysis.pdf
nhs_waiting_Analysis.ipynb
dashboard/index.html

---

## ⚙️ Run the Project
```bash
git clone https://github.com/Combatant94/nhs-waiting-times-analysis-2025.git
cd nhs-waiting-times-analysis-2025
pip install -r requirements.txt
jupyter notebook nhs_waiting_Analysis.ipynb
```

**Power BI Steps**
1. Import NHS_waiting_times_cleaned.csv into SQL Server (SSMS 2.0)
2. Run nhs_waiting_time.sql to create views
3. Connect Power BI → SQL Server → Model → Visualise

---

✅ **Results Summary**
- 80.99M total patient-records analysed (Apr–Jul 2025)
- 77.8% fell into "Other" due to a gap in my own band-matching rule (caught 12 of 104 actual labels) — found through validating the rule, not an NHS data issue
- 17.6% confirmed seen within 0–18 weeks
- 0.4% waited 52+ weeks
- July 2025 = peak activity (20.51M patient-records)
- SQL + Power BI automate NHS performance tracking
