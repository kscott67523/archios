function updateTMailStatus(checkbox, employeeId) {
  const isChecked = checkbox.checked;

  // Make AJAX request to update database
  if (isChecked) {
    // Send AJAX request to update database with employeeId and isChecked
    // Example using jQuery:
    $.ajax({
      url: '/employees/' + employeeId,
      method: 'PATCH',
      data: { has_tmail: isChecked },
      success: function(response) {
        console.log('TMail status updated successfully');
      },
      error: function(xhr, status, error) {
        console.error('Error updating TMail status:', error);
      }
    });
  }
}
