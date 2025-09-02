# 🛩️ DBF UAV Project – GENEI RYODAN (Summer 2023)

This repository contains the work of **Team GENEI RYODAN** in the **Design, Build, and Fly (DBF) Competition 2023**.  
We designed, built, and tested a **fixed-wing UAV** capable of carrying and dropping a medical payload safely.

---

## 📖 Executive Summary
The UAV was designed to fulfill the 2023 DBF mission:
1. Take off with a payload (medical supply box 12×12×12 cm).
2. Perform one complete lap around the course.
3. Drop the payload safely using a parachute.
4. Perform one lap without payload.
5. Land safely.

- **Empty weight:** ~1400 g  
- **Loaded weight:** ~2300 g (with payload)  
- **Max Take-off Weight (MTOW):** 2.5 kg  
- **Wingspan limit:** 160 cm  
- **Airfoil max thickness:** 4.5 cm  

The UAV was designed as a **single-boom, high-wing configuration** for stability, payload storage, and manufacturability.  
Propulsion and aerodynamic trade studies were done using **MATLAB, XFLR5, and CAD tools**, with fabrication using **laser cutting, 3D printing, and hot-wire cutting**.

---

## 📂 Repository Contents
- **Airfoils/** → `.dat` files of tested airfoils  
- **CAD/** → CAD design iterations (`.step` zipped)  
- **DBF-DXF/** → DXF parts for laser cutting  
- **GR Reports/** → Progress and final reports (`.pdf`, `.docx`)  
- **Iterations-XFLR5/** → Aerodynamic iterations (`.xfl` + results)  
- **MATLABCodes/** → UAV design and sizing code (details in report §4.3)  
- **Stability/** → Stability calculation spreadsheets  

---

## ⚙️ Design Highlights
- **Configuration:** Single-boom, high-wing, straight wing  
- **Mission Suitability:** Optimized for payload drop within 3–5 minutes  
- **Stability:** Verified via static & dynamic stability analysis (XFLR5 & MATLAB)  
- **Manufacturing:** Laser cutting (plywood), hot-wire cutting (foam wings), 3D printed connectors  
- **Testing:** Structural, propulsion, parachute deployment, and flight tests completed  

---

## 👥 Team Members
- **Team Leader:** Mohaned Hosny 
- **Aerodynamics:** Eslam Mahmoud, Mohamed Hossam  
- **Propulsion:** Abdullah Abdelgalel, Mohaned Hosny
- **CAD & Manufacturing:** Dalia Abdallah, Mohaned Hosny, Eslam Mahmoud  
- **Documentation:** All members  

---

## 📅 Timeline
- **Project period:** Summer 2023  
- **Repo initialized (retroactive):** 15 October 2023  

---

## 🚀 Future Work
- Improve aerodynamic efficiency (airfoil optimization)  
- Lighter and more efficient propulsion system  
- Stronger internal structure with minimal weight increase  
- Automated flight control integration  

---

## 📜 License
This project is shared for **educational and research purposes only**.  
Please cite this work if used in academic or technical contexts.

---
