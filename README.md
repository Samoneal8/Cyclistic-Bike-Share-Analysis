# Cyclistic Bike-Share Analysis: Case Study
**Project Goal:** To analyze how annual members and casual riders use Cyclistic bikes differently in order to design marketing strategies to convert casual riders into annual members.

##  1. Ask
* **Business Task:** Identify key differences between casual riders and annual members to guide marketing strategy.
* **Stakeholders:** Cyclistic executive team and Director of Marketing.

##  2. Prepare & Process
* **Data Source:** Cyclistic’s historical trip data (2020 Q1) Google Data Analytics.
* **Data Scale:** Analyzed over **426,000 rows** of raw trip data to ensure statistical significance.
* **Tools Used:** * **SQL (MS SQL Server):** Used for large-scale data cleaning and initial analysis.
    * **R (RStudio):** Used for advanced data visualization and statistical summaries.
* **Cleaning Steps:** * Removed maintenance/test station records (`HQ QR`).
    * Filtered out "false starts" (trips under 60 seconds) and outliers (trips over 24 hours).

##  3. Analyze & Share
* **Key Findings:**
    * **Ride Duration:** Casual riders have significantly higher average trip durations compared to members.
    * **Usage Patterns:** Members show high activity during weekdays (commuting), while casual riders peak during weekends (leisure).
    * **Volume:** Annual members account for a higher total volume of rides.

##  4. Act (Recommendations)
1. **Weekend Memberships:** Create a seasonal or weekend-only membership specifically for casual riders.
2. **Digital Campaigns:** Target casual riders with ads highlighting the cost-savings of membership for longer trips.
3. **Summer Incentives:** Increase marketing during peak leisure months when casual usage is highest.

---
### Files in this Repository
* `CyclisticProject.sql`: Full T-SQL script for data cleaning and analysis.
* `SH2020Q1 Rcode.R`: R script for visualizations.
* `Cyclistic Presentation.pdf`: Final stakeholder presentation slides.
