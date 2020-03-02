import places from 'places.js';

const initAutocomplete = () => {
  const locationInput = document.querySelector('#concert_hall_location');
  if (locationInput) {
    places({ container: locationInput });
  }
};

export { initAutocomplete };
