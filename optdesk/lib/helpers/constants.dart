
// For Admin

final Map<String, String> dataLocationSettingsAdmin = const {
  'Define domains for new user registration': 'Super Admin defines the list of domains allowed for the specific location',
  'Office Hours': 'Working hours are set by the Super Admin within which users can register available workstations',
  'Workstation Availability': 'Workstations are marked as available for the specific location taking into consideration social distancing norms',
  'Prior Days Booking': 'Super Admins set the number of days before which a user can block a workstations',
  'Max Days Booking': 'The maximum number a day’s a user can book is defined by the Super Admin',
  'Gap between Bookings': 'Super Admin defines the gap required between booking for the users',
  'Minimum hours to Book': 'Minimum hours to book a workstation is defined by the Super Admin',
};

final Map<String, String> dataUsersCanAdmin = {
  'New Users can register using the allowed domains': 'New users can register using the allowed domains for the specific location,Super Admins can also help create new users on request',
  'Book a workstation within location settings': 'Users can book a workstation within the restrictions placed by the Super Admins (location settings)',
  'Cancel a Booking': 'Users can cancel the booking by visiting the history section',
  'Scan a Workstation to Confirm Occupancy': 'Users need to scan the QR codes for booked workstation to confirm occupancy',
  'Reset the password': 'Password can be reset using the forgot password link',
};

final Map<String, String> dataNotificationsAdmin = {
  'Emails are triggered for Booking, Cancellation & Occupancy': 'An email is triggered to the registered user id on booking, cancellation, and occupancy',
  'History of Bookings and Cancellations': 'History of the workstations booked and cancelled are available for the user to view and manage',
};


// For User

final Map<String, String> dataLocationSettingsUser = const {
  'Defining domains for new user registration': 'For users the domains is pre-determined by the administrators as appropriate, default being the specific location',
  'Office Hours': 'Working hours are is pre-determined by the administrators as appropriate, within which users can register available workstations',
  'Workstation Availability': 'Workstations are marked as available for the specific location taking into consideration social distancing norms. This is a reduced capacity from the complete “normal” capacity.',
  'Pre-booking of workspaces': 'Pre-booking of workspaces is determined and set by the administrators as appropriate. At present, current setting allows a user to book 07 days before actual use of a workspace, including weekends.',
  'Max Days Booking at one time': 'The maximum number a day’s a user can book is determined and set by the administrators as appropriate. At present, current setting allows a user to book maximum of 2 workspaces at one time. In case of an individual making a cancellation out of two booked workspaces, he can re-book a workspace in lieu of the cancelled booking. Please do remember to refresh the page after booking to see the booked workspace in “My bookings” tab in the application on mobile and in “Booking History” on the web portal.',
  'Gap between Bookings': 'Gap between Bookings for the same workspace, on the same calendar day by two different users, is set at 30 minutes. This allows for the time for cleaning, preparation, and disinfection of the space between two users.',
  'Minimum hours to Book': """Minimum hours to book a workstation is determined and set by the administrators as appropriate. At present, current setting allows a user to book a workspace as under:\n\n  •	Full-day booking can be made on a working day from 0900h to 1900h, both inclusive.\n  •	Partial-day bookings – can be made in multiples of 2 hours, with 30 minutes gap between two bookings of the same workspace.""",
};

final Map<String, String> dataUsersCanUser = {
  'New Users can register using the allowed domains': 'New users can register using the allowed domains for the specific location as per determined settings. On request new user registration can be made by Super Admins.',
  'Book a workstation within location settings': """Users can book a workstation within the framework as determined (location settings). In the schematic of the floor which appears in the booking window, workspaces are colour coded as under:\n\n  •	Free and available to book for the complete day green colour\n  •	Partially Free and available to book for the balance day blue colour\n  •	Fully booked and unavailable red colour\n  •	Non-bookable due to social distancing gray colour\n  •	Fully Booked and in use red colour with a yellow border\n  •	Partially Booked and in use blue colour with a yellow border""",
  'Cancel after Booking': 'Users can cancel the booking by visiting the history section',
  'Scan a Workstation to Confirm Occupancy': 'Each workstation has a printout of a QR code which is unique and different for each workspace. After reaching the booked workspace for use, the users need to scan the QR codes for booked workstation to confirm occupancy. The QR code can be scanned 05 minutes before the commencement of the booking time.',
  'Reset the password': 'Password can be reset using the forgot password link',
};

final Map<String, String> dataNotificationsUser = {
  'Are emails are triggered for Booking, Cancellation & Occupancy? How do I know if my booking is accepted?': 'An email is triggered to the registered user id on booking, cancellation, and occupancy',
  'History of Bookings and Cancellations': 'History of the workstations booked and cancelled are available for the user to view and manage',
};