[{
  'repeat:10': {
    _id: '{{objectId()}}',
    index: '{{index()}}',
    guid: '{{guid()}}',
    isActive: '{{bool()}}',
    balance: '{{floating(1000, 4000, 2, "$0,0.00")}}',
    genImage: function (tags, parent) {
      var _gender = (Math.random() >= 0.5)? 'men/':'women/';
      return function(size) {
        return ['https://randomuser.me/api/portraits/',
        size,_gender,parent.index,'.jpg'].join('');
      };
    },
    picture_large: function (tags, parent) {
      return this.genImage('');
    },
    picture_medium: function (tags, parent) {
      return this.genImage('med/');
    },
    picture_thumbnail: function (tags, parent) {
      return this.genImage('thumb/');
    },
    age: '{{integer(20, 40)}}',
    firstname: '{{firstName()}}',
    lastname: '{{surname()}}',
    username: function(tags) {
      return this.firstname.charAt(0)+this.lastname+ Math.floor(Math.random() * 10) + 1;
    },
    company: '{{company().toUpperCase()}}',
    email: function (tags) {
      // Email tag is deprecated, because now you can produce an email as simple as this:
      return (this.firstname + '.f' + this.lastname + '@' + this.company + tags.domainZone()).toLowerCase();
    },
    phone: '+1 {{phone()}}',
    address: '{{integer(100, 999)}} {{street()}}, {{city()}}, {{state()}}, {{integer(100, 10000)}}',
    about: '{{lorem(1, "paragraphs")}}',
    registered: '{{moment(this.date(new Date(2014, 0, 1), new Date())).format("LLLL")}}',
    latitude: '{{floating(-90.000001, 90)}}',
    longitude: '{{floating(-180.000001, 180)}}',
    friends: [{
      'repeat:3': {
        id: '{{index()}}',
        name: '{{firstName()}} {{surname()}}'
      }
    }]
  }
}]