
VULKAN_SDK = os.getenv("VULKAN_SDK")
if (VULKAN_SDK == nil or VULKAN_SDK == '') then
   VULKAN_SDK = os.getenv("VK_SDK_PATH")
   if (VULKAN_SDK == nil or VULKAN_SDK == '') then
      error("Coundn't load VulkanSDK, you may want to change the environement variable name or define it; syntax : VULKAN_SDK={path to the SDK directory}")
   end
end

printf("Found VulkanSDK at path : %s", VULKAN_SDK)

outputdir = Solution.Path.OutputDirectory

Solution.ProjectsInfo.Includes["ProjectCore"] = {
   "%{Solution.Projects.Walnut}/%{VULKAN_SDK}/Include",
   "%{Solution.Projects.Walnut}/vendor/glm",
   "%{Solution.Projects.Walnut}/vendor/imgui",
   "%{Solution.Projects.Walnut}/vendor/glfw/include",
   "%{Solution.Projects.Walnut}/vendor/stb_image",
   "%{Solution.Projects.Walnut}/src"
}

Solution.Projects["GLFW"] 	   = "vendor/GLFW"
Solution.Projects["ImGui"] 	= "vendor/imgui"

group "Dependencies"
	include (Solution.Projects["GLFW"])
	include (Solution.Projects["ImGui"])
group ""

project "Walnut"
   kind "StaticLib"
   language "C++"
   cppdialect "C++20"
   staticruntime "off"

   targetdir 	(Solution.Path.ProjectTargetDirectory)
   objdir 		(Solution.Path.ProjectObjectDirectory)

   files { "src/**.h", "src/**.cpp" }

   links
   {
       "ImGui",
       "GLFW",
       "%{VULKAN_SDK}/Lib/vulkan-1.lib"
   }

	Solution.Project("Walnut")

   filter "system:windows"
      defines { "WL_PLATFORM_WINDOWS" }

   filter "configurations:Debug"
      defines { "WL_DEBUG" }

   filter "configurations:Release"
      defines { "WL_RELEASE" }

   filter "configurations:Dist"
      defines { "WL_DIST" }