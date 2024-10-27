String ocassionSchema = """
query GetAllOccasions {
  getAllOccasions {
    name
    _id
    categories {
      name
      label
      _id
      personalizeImage
      image
    }
  }
}
""";