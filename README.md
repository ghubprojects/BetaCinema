<p align="center">
	<img src="https://github-production-user-asset-6210df.s3.amazonaws.com/83504674/464482097-8b82793a-3dfa-4908-ab6e-de8c532dc44f.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250710%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250710T032652Z&X-Amz-Expires=300&X-Amz-Signature=52ca35461b7feb0c19c42f2c180b82d4594ef5500e0b87360812c0405acca4d3&X-Amz-SignedHeaders=host" width="150" >
</p>

<h1 align="center">BetaCinema</h1>
<p align="center">An online cinema ticket booking system.</p>

## Tech Stack
- **Frontend:** Blazor Server (.NET 6)
- **Backend:** ASP.NET Core with Identity
- **Payment:** VNPay integration
- **Database:** PostgreSQL

## Features
- User registration, login, and role-based access (user/admin).
- Movie scheduling and seat selection.
- Secure online payments with VNPay.
- Email confirmations for bookings.
- Admin dashboard for managing movies, showtimes, seat maps, invoices.
- Excel import/export support.

## Screenshots
- **Home Screen**
<p>
	<img src="https://github-production-user-asset-6210df.s3.amazonaws.com/83504674/464482149-2d142bd9-63e2-4a6e-bf46-d27a20fc6c80.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250710%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250710T032910Z&X-Amz-Expires=300&X-Amz-Signature=bc421d0c23586230c42bcbea1f76f4de0541fb35f28caf744f6e46f14f8e7049&X-Amz-SignedHeaders=host" />
</p>

- **Showtimes Screen**
<p>
	<img src="https://github-production-user-asset-6210df.s3.amazonaws.com/83504674/464482147-860a86ce-a926-4d9f-9cc9-8352327149ba.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250710%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250710T032844Z&X-Amz-Expires=300&X-Amz-Signature=6084c659c57f290fc0f8d22166bf27654f5730d7dea10baa2ff401120a6ef8d3&X-Amz-SignedHeaders=host" />
</p>

- **Reservation Screen**
<p>
	<img src="https://github-production-user-asset-6210df.s3.amazonaws.com/83504674/464482146-2073362d-f260-48d6-a964-8b665da0b590.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250710%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250710T032816Z&X-Amz-Expires=300&X-Amz-Signature=1656b1bfa214ef83abeaa547b3819a1e11dc02f38f944a4db7ac96a6173a413e&X-Amz-SignedHeaders=host" />
</p>

- **Payment Screen**
<p>
	<img src="https://github-production-user-asset-6210df.s3.amazonaws.com/83504674/464482148-f4691d2b-aab5-4e0e-9bdc-15be9cfcc1e9.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250710%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250710T032751Z&X-Amz-Expires=300&X-Amz-Signature=0c9adfeb08811bd0e4c803bd4bb0b71557a4ce8e60f040b0b31ff4dbbf6bf0a9&X-Amz-SignedHeaders=host" />
</p>

- **Profile Screen**
<p>
	<img src="https://github-production-user-asset-6210df.s3.amazonaws.com/83504674/464481089-da57bcd0-6051-4821-9fd6-ecb71ba6a0ef.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250710%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250710T032215Z&X-Amz-Expires=300&X-Amz-Signature=5b3092185f3fee579726457d2045446c8f05e4a1d2d1ced4ae091bbbfc48183e&X-Amz-SignedHeaders=host" />
</p>

- **Movie List Screen (Admin)**
<p>
	<img src="https://github-production-user-asset-6210df.s3.amazonaws.com/83504674/464478474-823a0d61-3e6a-4e73-bb2b-45eacd4de0f9.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250710%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250710T032342Z&X-Amz-Expires=300&X-Amz-Signature=78480aef0d65b74c49f007938e29e64995c73fede2dfd5a96ffc9ca7fa9f3d1a&X-Amz-SignedHeaders=host" />
</p>

- **Edit Movie Screen (Admin)**
<p>
	<img src="https://github-production-user-asset-6210df.s3.amazonaws.com/83504674/464478473-37033bcb-267e-4d25-aad1-9b7df39214de.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250710%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250710T032334Z&X-Amz-Expires=300&X-Amz-Signature=169e3fb037a555675b59c6dbb9d761cda9e4e52eaa8e5a93ba36798ce06d492e&X-Amz-SignedHeaders=host" />
</p>

- **Excel Export Result**
<p>
	<img src="https://github-production-user-asset-6210df.s3.amazonaws.com/83504674/464478456-a7e10bb7-7276-487f-bff9-0c9e1ea61b0f.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250710%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250710T032446Z&X-Amz-Expires=300&X-Amz-Signature=76fb0d967f280c64c3a2cf067f5df177a45eb09be6f9dbddef4dd3ef807429d9&X-Amz-SignedHeaders=host" />
</p>

## Contributors

| <img src="https://github-production-user-asset-6210df.s3.amazonaws.com/83504674/242248844-6a937701-fda2-49c7-8988-d6cb81dc6e82.jpg" width="100px" alt="user-image"/><br />[The Anh](https://github.com/ghubprojects) |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
