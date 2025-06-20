# To Do

- Folder vs Groups
	- Check for conflicts
	- Use folders instead of groups at the root level
- New project
	- Create a template for future projects
	- Decide between a single xcodepro or a workspace
- Configs
	- Avoid using four configurations per xcodeproj (DerivedData build path)
	- Is individual versioning needed per module?
	- Remove configs from Copy Resources phase
	- Add a dev menu for development builds
	- Add a custom script to prohibit Build Settings changes in xcodeproj
- Linking, Dependencies
	- Embed and sign only in final apps
	- Investigate auto-linking of nested dependencies
	- SPM dependency (Firebase, Kingfisher/Nuke)
	- SPM dependency shared across multiple targets in different projects
- L1–L2
	- Add a tab bar with three preloaded features
	- `MainFactory` (L1) + `ModuleFactory` (L2) – inject dependencies (API, Analytics, and a repository for business data)
	- Navigation: a module in the tab bar initializes section switching or opens another feature
	- Navigation: two features switch within a shared container controller
- L2 Shared UI
	- Component to download, cache, and display an image (wrapper over Kingfisher or Nuke)
- L3–L4
	- API + Networking example + Authentication (also related to L1–L2)
	- Analytics (consider moving event tracking to L2)
	- Example repository for User Account or other data types
- L4 Storage
	- Property observation
	- Keychain support
	- Support for raw data (files, images)
	- UserDefaults + App Group (for widget support)
	- Base migration strategy
- L4 Design System
- Tests
	- Module: unit testing
	- App: UI/integration testing
