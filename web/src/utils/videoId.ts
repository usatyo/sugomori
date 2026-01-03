const checkVideoId = (url: string): boolean => {
  const regexp = /^[a-zA-Z0-9_-]{11}$/
  return regexp.test(url)
}

const pickUpVideoId = (url: string): string | null => {
  try {
    const urlObject = new URL(url)
    if (
      urlObject.hostname !== "www.youtube.com" &&
      urlObject.hostname !== "youtu.be"
    ) {
      return null
    } else if (
      urlObject.searchParams.get("v") !== null &&
      checkVideoId(urlObject.searchParams.get("v")!)
    ) {
      return urlObject.searchParams.get("v")
    } else if (
      urlObject.pathname.split("/").pop() !== undefined &&
      checkVideoId(urlObject.pathname.split("/").pop()!)
    ) {
      return urlObject.pathname.split("/").pop()!
    } else {
      return null
    }
  } catch (e) {
    return null
  }
}

export { checkVideoId, pickUpVideoId }
