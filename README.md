# Ascend: Life RPG

A full-stack life gamification app built with React, TypeScript, Tailwind CSS, Express, PostgreSQL and JWT authentication.

## Features
- Landing, login and registration
- Dashboard with XP, Gold, stats, streaks and activity
- Quest creation, editing, deletion and completion
- XP, Gold and attribute rewards
- Shop with badges, themes and affordable starter rewards
- Purchase validation and owned-state feedback
- Inventory
- Leaderboard
- Achievements with progress tracking
- Progress analytics and recent victories
- Profile and theme synchronization
- Responsive sidebar navigation

## Run locally
1. Start Docker Desktop.
2. From the project root run `docker compose up -d db`.
3. Load the database schema once:
   `Get-Content .\server\schema.sql | docker exec -i ascend-life-rpg-db-1 psql -U ascend -d ascend`
4. Create `server/.env` from `.env.example`:
   `DATABASE_URL=postgresql://ascend:ascend@localhost:5432/ascend`
   `JWT_SECRET=change-this-in-local-development`
   `CLIENT_URL=http://localhost:5173`
   `PORT=5000`
5. Run `npm install` in the root.
6. Run `npm run dev`.
7. Open http://localhost:5173/

If port 5173 or 5000 is already in use, stop the previous development process before starting another copy.


## Marketplace & Payments
The upgraded build includes digital Gold rewards, a physical-product marketplace, delivery details, orders, Gold discounts, and Razorpay Checkout integration. Add `RAZORPAY_KEY_ID` and `RAZORPAY_KEY_SECRET` to `server/.env` to enable real/test payments. Never commit secret keys.

### Amazon / Flipkart fulfilment
The demo includes external marketplace links. A normal Amazon/Flipkart link can send the shopper to that marketplace, where Amazon/Flipkart collects payment and uses its own address/fulfilment flow. It does **not** allow Ascend to collect the payment inside Ascend and silently make Amazon ship the order. For commission, use the marketplace's official affiliate/partner program and replace the sample links with your approved tagged links.

### Production checklist
- Use Razorpay live keys only after KYC/merchant onboarding and domain configuration.
- Use HTTPS in production.
- Configure CORS to your deployed frontend domain.
- Configure a payment webhook and verify signatures server-side.
- For physical goods, use your own supplier/fulfilment partner or an approved marketplace/affiliate flow.
