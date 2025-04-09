<%@ include file="header.jsp" %>
<h1>Manage Bookings</h1>

<div class="search-bar">
  <input type="text" placeholder="Search bookings...">
  <button class="btn">Search</button>
  <button class="btn" style="float: right;">+ Add New Booking</button>
</div>

<table>
  <thead>
  <tr>
    <th>Booking ID</th>
    <th>Customer</th>
    <th>Service</th>
    <th>Date</th>
    <th>Time</th>
    <th>Status</th>
    <th>Actions</th>
  </tr>
  </thead>
  <tbody>
  <tr>
    <td>BK1001</td>
    <td>John Doe</td>
    <td>Hotel Booking</td>
    <td>2023-06-15</td>
    <td>14:00</td>
    <td>Confirmed</td>
    <td>
      <button class="btn">Edit</button>
      <button class="btn" style="background-color: #dc3545;">Cancel</button>
    </td>
  </tr>
  <tr>
    <td>BK1002</td>
    <td>Jane Smith</td>
    <td>Flight Booking</td>
    <td>2023-06-16</td>
    <td>09:30</td>
    <td>Pending</td>
    <td>
      <button class="btn">Edit</button>
      <button class="btn" style="background-color: #dc3545;">Cancel</button>
    </td>
  </tr>
  <tr>
    <td>BK1003</td>
    <td>Robert Johnson</td>
    <td>Car Rental</td>
    <td>2023-06-17</td>
    <td>10:00</td>
    <td>Completed</td>
    <td>
      <button class="btn">Edit</button>
      <button class="btn" style="background-color: #dc3545;">Cancel</button>
    </td>
  </tr>
  <tr>
    <td>BK1004</td>
    <td>Sarah Williams</td>
    <td>Event Tickets</td>
    <td>2023-06-18</td>
    <td>19:00</td>
    <td>Confirmed</td>
    <td>
      <button class="btn">Edit</button>
      <button class="btn" style="background-color: #dc3545;">Cancel</button>
    </td>
  </tr>
  </tbody>
</table>

<div style="margin-top: 20px;">
  <button class="btn">Previous</button>
  <button class="btn">Next</button>
</div>
<%@ include file="footer.jsp" %>