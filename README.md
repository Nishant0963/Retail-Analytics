**Retail Analysis — Excel, SQL & Power BI
📌 Project Overview**
This project focuses on analyzing retail sales data to understand **product performance, customer purchasing behavior, sales trends, category performance, and customer loyalty**.
The project follows an end-to-end data analytics workflow using:
**Excel → SQL → Power BI**
Each tool was used for a specific stage of the analysis, from initial data preparation and validation to SQL-based business analysis and interactive dashboard creation.
**🎯 Business Problem**
The company wants to better understand its sales and customer data to improve business performance, marketing decisions, inventory planning, and customer retention.
The analysis focuses on questions such as:
• Which products generate the highest sales revenue?
• Which products have the lowest sales volume?
• Which product categories perform best?
• How frequently do customers purchase?
• Which customers are high-frequency or low-frequency buyers?
• Which customers make repeat purchases?
• How long do customers remain active?
• How is revenue changing over time?
• What is the month-over-month sales growth?
• How should customers be segmented based on their purchase quantity?
**🛠️ Tools & Technologies**ToolPurpose**Microsoft Excel**Initial data preparation, missing-value checks, data consolidation, Pivot Tables and summaries**SQL**Data cleaning, validation, transformation and business analysis**Power BI**Data modeling, DAX calculations, KPIs and interactive dashboard
**📂 Dataset**
The project uses retail data containing information about:
**Product / Inventory Data**
• ProductID
• ProductName
• Category
• StockLevel
• Price
**Sales Transaction Data**
• TransactionID
• CustomerID
• ProductID
• QuantityPurchased
• TransactionDate
• Price
**Customer Data**
• CustomerID
• Age
• Gender
• Location
• JoinDate
• Reset_Location
**1️⃣ Excel — Data Preparation & Initial Analysis**
Excel was used as the first stage of the project to understand, prepare and validate the available data before performing detailed SQL analysis.
**🔹 Missing Value Check**
The dataset was checked for:
• Blank cells
• Missing customer information
• Missing product information
• Missing transaction details
• Missing location/category values
This helped identify data-quality issues before further analysis.
**🔹 Combining Data**
The required datasets were combined into a single worksheet for initial analysis and easier data understanding.
The combined data allowed analysis of:
• Customer information
• Product information
• Transaction details
• Quantity purchased
• Price
• Category
• Location
**🔹 Table Checks**
Excel Tables were reviewed to check:
• Number of records
• Column structure
• Data consistency
• Duplicate records
• Missing values
• Incorrect or inconsistent values
**🔹 Pivot Table Analysis**
Pivot Tables were created to summarize the data and identify initial business patterns.
Examples include:
• Sales by product
• Sales by category
• Sales by location
• Quantity sold by product
• Customer transaction frequency
• Sales summaries
The Excel analysis provided an initial understanding of the dataset before moving to SQL.
**2️⃣ SQL — Data Cleaning & Business Analysis**
SQL was used for detailed **data cleaning, validation, transformation, and business analysis**.
The following 16 business questions were addressed.
**🧹 Data Cleaning & Validation
1. Duplicate Transaction Check**
Identified the number of duplicate records in the `sales_transaction` table.
A separate table containing unique records was created. The original table was then removed and the new table was renamed to the original table name.
**2. Price Discrepancy Check**
Compared product prices between the `sales_transaction` and `product_inventory` tables.
Price discrepancies were identified and updated so that the prices matched between the tables.
**3. NULL Value Handling**
Identified NULL values in the dataset and replaced appropriate missing values with:

`Unknown`

This improved consistency and allowed the data to be used more effectively for analysis.
**4. Date Data Cleaning**
The date column was initially stored in `TEXT` format.
The following process was performed:
1. Created a separate table.
2. Converted the date column from `TEXT` to the appropriate `DATE` data type.
3. Removed the original table.
4. Renamed the new table to replace the original table.
This allowed accurate date-based analysis.
**📊 Sales & Product Analysis
5. Product Sales Summary**
Calculated the:
• Total sales per product
• Total quantity sold per product
This helped evaluate product-level performance.
**6. Customer Transaction Frequency**
Counted the number of transactions made by each customer to understand purchase frequency.
**7. Product Category Performance**
Calculated total sales for each product category.
This helps identify categories that perform well and can be prioritized in marketing campaigns.
**8. Top 10 Products by Revenue**
Identified the **top 10 products with the highest total sales revenue**.
This helps the company identify high-revenue products that can receive additional marketing and business focus.
**9. Bottom 10 Products by Units Sold**
Identified the **10 products with the fewest units sold**, considering only products where at least one unit was sold.
This helps identify products with relatively low demand.
**📈 Sales Trend & Growth Analysis
10. Sales Trend**
Analyzed sales over time to understand the company's revenue pattern.
The analysis helps identify:
• Increasing revenue
• Decreasing revenue
• Periodic sales patterns
• Overall sales movement
**11. Month-over-Month Sales Growth**
Calculated the **Month-over-Month (MoM) growth rate** of company sales.
This helps understand how revenue changes from one month to the next and identify periods of positive or negative growth.
**👥 Customer Analysis
12. High-Frequency Customers**
Identified customers with higher purchase frequency and calculated:
• Number of transactions
• Total amount spent
This helps identify valuable customers who may be targeted with retention and loyalty campaigns.
**13. Low-Frequency Customers**
Identified occasional or low-frequency customers and calculated:
• Number of transactions
• Total amount spent
This helps identify customers who may require additional engagement or promotional campaigns.
**14. Repeat Customer Purchases**
Calculated the total number of purchases made by each customer for each `ProductID`.
This helps understand:
• Repeat customers
• Frequently purchased products
• Customer-product purchasing behavior
**15. Customer Purchase Duration**
Calculated the duration between each customer's:
• First purchase
• Last purchase
This helps understand customer loyalty and the length of their relationship with the company.
**🎯 Customer Segmentation
16. Customer Segmentation by Quantity Purchased**
Customers were segmented based on the **total quantity of products purchased**.
The number of customers in each segment was also calculated.
This helps the company:
• Identify high-volume customers
• Identify low-volume customers
• Understand purchasing levels
• Create targeted marketing strategies
**3️⃣ Power BI — Dashboard & Visualization**
Power BI was used to transform the analyzed data into an interactive **Retail Analytics Dashboard**.

**🔹 Dashboard Preview** 

!Screenshot 2026-10-08 215214.png

**🔹 Data Model**
The project follows a simple star-schema structure:

                 `Product
                    │
                    │
                    ▼
Customer ───── Sale Transaction`

**Relationships**

`Product[ProductID]
       1
       │
       *
Sale Transaction[ProductID]

Customer[CustomerID]
       1
       │
       *
Sale Transaction[CustomerID]`

The **Sale Transaction** table acts as the main fact table, while **Product** and **Customer** act as dimension tables.
**📌 Top 5 KPIs**
The dashboard contains five key performance indicators:
**1. Total Revenue**
Measures the total revenue generated from sales transactions.

`Total Revenue =
SUMX(
    'Sale Transaction',
    'Sale Transaction'[QuantityPurchased] *
    'Sale Transaction'[Price]
)`

**2. Units Sold**

`Units Sold =
SUM('Sale Transaction'[QuantityPurchased])`

**3. Total Customers**

`Total Customers =
DISTINCTCOUNT('Sale Transaction'[CustomerID])`

**4. Total Products**

`Total Products =
DISTINCTCOUNT(Product[ProductID])`

**5. Repeat Customer %**

`Repeat Customers =
COUNTROWS(
    FILTER(
        VALUES('Sale Transaction'[CustomerID]),
        CALCULATE(
            COUNT('Sale Transaction'[TransactionID])
        ) > 1
    )
)`

`Repeat Customer % =
DIVIDE(
    [Repeat Customers],
    [Total Customers],
    0
)`

**📊 Dashboard Visualizations**
The dashboard contains important visuals based on the business requirements.
**1. Revenue Trend — Line Chart**
Shows revenue movement over time.
**Purpose:**
• Understand sales trends.
• Identify periods of growth or decline.
• Observe the company's revenue pattern.
**2. Revenue by Category — Bar Chart**
Shows total revenue generated by each product category.
**Purpose:**
• Compare category performance.
• Identify high-performing categories.
• Support marketing decisions.
**3. Revenue by Location — Pie Chart**
Shows revenue generated across customer locations.
**Purpose:**
• Identify high-performing locations.
• Compare regional sales performance.
**4. Top 10 Products — Bar Chart**
Displays the top 10 products based on total sales revenue.
**Purpose:**
• Identify high-revenue products.
• Support product-focused marketing decisions.
**🔄 Project Execution Workflow**

                    `RAW DATA
                       │
                       ▼
                    EXCEL
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
    Missing Value   Combine Data   Table Check
       Check                       & Pivot
          │            │            │
          └────────────┼────────────┘
                       ▼
                      SQL
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
   Data Cleaning   Validation    Business Queries
        │              │              │
        └──────────────┼──────────────┘
                       ▼
                    POWER BI
                       │
              ┌────────┼────────┐
              ▼        ▼        ▼
           Data Model DAX    Visuals
              │        │        │
              └────────┼────────┘
                       ▼
              TOP 5 KPIs
                       │
                       ▼
             INTERACTIVE DASHBOARD
                       │
                       ▼
             BUSINESS INSIGHTS
                       │
                       ▼
             RECOMMENDATIONS`

**💡 Business Insights & Recommendations**
The analysis can help the company make decisions around:
**Product Strategy**
• Focus on high-revenue products.
• Review products with low sales volume.
• Identify products requiring additional promotion.
**Marketing Strategy**
• Promote high-performing product categories.
• Target high-frequency customers with loyalty campaigns.
• Re-engage low-frequency customers through targeted offers.
**Customer Retention**
• Monitor repeat purchasing behavior.
• Identify customers with longer purchase durations.
• Develop strategies to increase customer frequency.
**Sales Strategy**
• Monitor monthly revenue trends.
• Track month-over-month growth.
• Identify periods of declining sales.
**Inventory Strategy**
• Monitor high-demand products with low stock.
• Review products with high stock and low sales.
**🏁 Final Outcome**
The project provides an end-to-end retail analytics solution using:
**Excel → SQL → Power BI**
Excel was used for **initial data preparation and validation**, SQL was used for **data cleaning and detailed business analysis**, and Power BI was used to create an **interactive dashboard with KPIs and business-focused visualizations**.
The final dashboard provides a consolidated view of:
• Revenue
• Units sold
• Customers
• Products
• Product categories
• Customer behavior
• Repeat purchases
• Sales trends
• Customer segments
• Product and inventory performance
The project demonstrates how raw retail data can be transformed into **structured analysis and actionable business insights**.
